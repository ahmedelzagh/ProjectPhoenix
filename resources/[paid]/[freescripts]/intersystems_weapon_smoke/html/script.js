// INPUTS LOGIC
let criticalTimer = null;

const inHeat = document.getElementById('in-heat');
const inMax = document.getElementById('in-max');
const inDur = document.getElementById('in-dur');
const inDict = document.getElementById('in-dict'); 
const inName = document.getElementById('in-name'); 

inHeat.addEventListener('input', (e) => document.getElementById('val-heat').innerText = parseFloat(e.target.value).toFixed(2));
inMax.addEventListener('input', (e) => document.getElementById('val-max').innerText = parseFloat(e.target.value).toFixed(1));
inDur.addEventListener('input', (e) => document.getElementById('val-dur').innerText = parseFloat(e.target.value).toFixed(1));

function openSettings(data) {
    document.getElementById('logic-modal').classList.add('visible');
    
    inHeat.value = data.heat; document.getElementById('val-heat').innerText = data.heat.toFixed(2);
    inMax.value = data.max; document.getElementById('val-max').innerText = data.max.toFixed(1);
    inDur.value = data.dur; document.getElementById('val-dur').innerText = data.dur.toFixed(1);
    
    inDict.value = data.dict || "";
    inName.value = data.name || "";

    // Movement
    const moveCheck = document.getElementById('in-movement');
    moveCheck.checked = data.natural; 
    document.getElementById('val-movement').innerText = data.natural ? "NATURAL" : "ATTACHED";
    document.getElementById('val-movement').style.color = data.natural ? "#10b981" : "#9ca3af";
    moveCheck.onchange = function() {
        document.getElementById('val-movement').innerText = this.checked ? "NATURAL" : "ATTACHED";
        document.getElementById('val-movement').style.color = this.checked ? "#10b981" : "#9ca3af";
    };

    // Jamming Switch
    const jamCheck = document.getElementById('in-jamming');
    jamCheck.checked = data.jamming !== false; 
    const updateJamText = () => {
        document.getElementById('val-jamming').innerText = jamCheck.checked ? "ON" : "OFF";
        document.getElementById('val-jamming').style.color = jamCheck.checked ? "#ef4444" : "#9ca3af";
    };
    jamCheck.onchange = updateJamText;
    updateJamText();

    const inJamDur = document.getElementById('in-jam-dur');
    inJamDur.value = data.jamDur;
    document.getElementById('val-jam-dur').innerText = data.jamDur.toFixed(1);
    
    inJamDur.oninput = (e) => {
        document.getElementById('val-jam-dur').innerText = parseFloat(e.target.value).toFixed(1);
    };
}

function closeSettings() {
    document.getElementById('logic-modal').classList.remove('visible');
    fetch(`https://${GetParentResourceName()}/closeSettings`, { method: 'POST' });
}

function saveSettings() {
    const data = {
        heat: parseFloat(inHeat.value),
        max: parseFloat(inMax.value),
        dur: parseFloat(inDur.value),
        dict: inDict.value,
        name: inName.value,
        natural: document.getElementById('in-movement').checked,
        jamming: document.getElementById('in-jamming').checked,
        jamDur: parseFloat(document.getElementById('in-jam-dur').value)
    };
    fetch(`https://${GetParentResourceName()}/saveSettings`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    });
    document.getElementById('logic-modal').classList.remove('visible');
}

// NOTIFICATIONS & MAIN LOGIC
function showNotification(type, title, message) {
    const container = document.getElementById('notify-container');
    const el = document.createElement('div');
    el.className = `notify-toast type-${type}`; 
    el.innerHTML = `<div class="notify-icon">${title}</div><div class="notify-text">${message}</div>`;
    container.appendChild(el);
    setTimeout(() => el.classList.add('visible'), 10);
    setTimeout(() => { el.classList.remove('visible'); setTimeout(() => el.remove(), 300); }, 3000);
}

let isLeftMouseDown = false;
let isRightMouseDown = false;
let isMouseActive = false;

window.addEventListener('message', function(event) {
    const item = event.data;

    if (item.type === "play_sound") {
        let audio = new Audio(item.file);
        audio.volume = item.volume;
        audio.play();
        return;
    }

    if (item.type === "open_particle_browser") {
        toggleParticleMenu(true);
    }

    const dashboard = document.getElementById('dashboard');
    const heatTextLabel = document.getElementById('heat-text-label');

if (item.type === "heat_update") {
        const barWrapper = document.getElementById('heat-wrapper');
        const barContainer = document.getElementById('heat-container');
        const barFill = document.getElementById('heat-fill');
        const barIcon = document.getElementById('heat-icon-el');
        
        const pngWrapper = document.getElementById('png-wrapper');
        const pngBg = document.getElementById('png-bg');
        const pngFill = document.getElementById('png-fill');
        
if (item.active) {
            let pct = (item.current / item.max) * 100;
            if (pct < 2) pct = 0; 
            if (pct > 98) pct = 100;
            
            if (item.style === "PNG") {
                barWrapper.classList.remove('visible');
                pngWrapper.classList.add('visible');    
                
                const imgUrl = `url('img/${item.weapon}.png')`;
                pngBg.style.webkitMaskImage = imgUrl;
                pngFill.style.webkitMaskImage = imgUrl;
                
                let clipVal = 100 - pct; 
                pngFill.style.clipPath = `inset(0 ${clipVal}% 0 0)`;
                heatTextLabel.style.clipPath = `inset(0 ${clipVal}% 0 0)`;
                if (pct <= 0) {
                    pngFill.style.opacity = "0"; 
                } else {
                    if (pct <= 90) { 
                        pngFill.style.opacity = "1"; 
                    }
                }
                
                if (pct > 90) {
                    pngFill.classList.add('critical');
                    heatTextLabel.classList.add('critical');
                    heatTextLabel.innerText = item.text || "OVERHEAT!";
                    
                    if (criticalTimer) {
                        clearTimeout(criticalTimer);
                        criticalTimer = null;
                    }

                    criticalTimer = setTimeout(() => {
                        pngFill.classList.remove('critical');
                        heatTextLabel.classList.remove('critical');
                        heatTextLabel.innerText = "WEAPON HOT";
                        criticalTimer = null; 
                    }, 3000);

                } else {

                    if (!criticalTimer) {
                        pngFill.classList.remove('critical');
                        heatTextLabel.classList.remove('critical');
                        heatTextLabel.innerText = "WEAPON HOT";
                    }
                }

                } else {
                pngWrapper.classList.remove('visible');
                barWrapper.classList.add('visible');
                barFill.style.width = pct + "%";
                
                const barText = document.getElementById('heat-text');
                
                if (pct > 75) {
                    barFill.style.backgroundColor = "#e14040";
                    barContainer.classList.add('critical-state');
                    barIcon.classList.add('critical');
                    
                    if (barText) {
                        barText.innerText = item.text || "OVERHEAT!";
                        barText.classList.add('critical');
                    }
                } else {
                    barFill.style.backgroundColor = "rgba(240, 201, 41, 0.9)";
                    barContainer.classList.remove('critical-state');
                    barIcon.classList.remove('critical');
                    
                    if (barText) {
                        barText.classList.remove('critical');
                    }
                }
            }
            
        } else {
            if (barWrapper) barWrapper.classList.remove('visible');
            if (pngWrapper) pngWrapper.classList.remove('visible');
            
            setTimeout(() => {
                if(barContainer) barContainer.classList.remove('critical-state');
                if(barIcon) barIcon.classList.remove('critical');
                if(pngFill) pngFill.classList.remove('critical');
                if(heatTextLabel) heatTextLabel.classList.remove('critical');
            }, 300);
        }
    }

    if (item.type === "open_settings") openSettings(item);
    if (item.type === "notification") showNotification(item.style, item.title, item.message);

    if (item.type === "ui") {
        if (item.display) {
            dashboard.style.display = 'flex'; setTimeout(() => dashboard.classList.add('visible'), 10);
        } else {
            dashboard.classList.remove('visible'); setTimeout(() => dashboard.style.display = 'none', 300);
            document.getElementById('logic-modal').classList.remove('visible');
            isLeftMouseDown = false; isRightMouseDown = false;
        }
    }

    if (item.type === "update") {
        const modeEl = document.getElementById('mode-badge');
        if (item.mode === "POS") { modeEl.innerText = "MOVE"; modeEl.className = "badge active"; }
        else { modeEl.innerText = "ROTATE"; modeEl.className = "badge rot"; }

        const gizmoEl = document.getElementById('gizmo-badge');
        gizmoEl.className = item.gizmoVisible ? "badge gizmo-on" : "badge gizmo-off";

        const speedEl = document.getElementById('speed-badge');
        speedEl.innerText = item.speedName;
        speedEl.className = "badge spd-" + item.speedName;

        const ctrlBadge = document.getElementById('ctrl-badge');
        if (item.isCtrlHeld || isRightMouseDown) { ctrlBadge.style.opacity = "1"; ctrlBadge.classList.add("ctrl-active"); } 
        else { ctrlBadge.style.opacity = "0.3"; ctrlBadge.classList.remove("ctrl-active"); }

        isMouseActive = item.isMouseActive;
        const xKey = document.getElementById('key-x');
        if (isMouseActive) xKey.classList.add("mouse-active"); else xKey.classList.remove("mouse-active");

        document.getElementById('auto-val').innerText = item.autoplay ? "ON" : "OFF";
        document.getElementById('auto-val').style.color = item.autoplay ? "#10b981" : "#6b7280";
        
        document.getElementById('px').innerText = item.pos.x.toFixed(3);
        document.getElementById('py').innerText = item.pos.y.toFixed(3);
        document.getElementById('pz').innerText = item.pos.z.toFixed(3);
        document.getElementById('rx').innerText = item.rot.x.toFixed(1);
        document.getElementById('ry').innerText = item.rot.y.toFixed(1);
        document.getElementById('rz').innerText = item.rot.z.toFixed(1);
        document.getElementById('scale-val').innerText = item.scale.toFixed(2);
    }
});

document.addEventListener('mousedown', (e) => {
    const isMenuOpen = document.getElementById('particle-modal').classList.contains('visible');
    
    if (!isMouseActive && !isMenuOpen) return;
    
    if (e.button === 0) {
        if (isMouseActive && !isMenuOpen) {
            isLeftMouseDown = true;
            fetch(`https://${GetParentResourceName()}/startDrag`, { 
                method: 'POST', 
                headers: { 'Content-Type': 'application/json' }, 
                body: JSON.stringify({ x: e.clientX / window.innerWidth, y: e.clientY / window.innerHeight }) 
            });
        }
    }
    
    if (e.button === 2) {
        isRightMouseDown = true; 
    }
});

document.addEventListener('mouseup', (e) => {
    if (e.button === 0) {
        if (isLeftMouseDown && isMouseActive) {
            fetch(`https://${GetParentResourceName()}/stopDrag`, { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({}) });
        }
        isLeftMouseDown = false;
    }
    if (e.button === 2) { isRightMouseDown = false; }
});

document.addEventListener('mousemove', (e) => {
    const isMenuOpen = document.getElementById('particle-modal').classList.contains('visible');

    if (!isMouseActive && !isMenuOpen) return;
    if (isLeftMouseDown && isMouseActive && !isMenuOpen) { 
        fetch(`https://${GetParentResourceName()}/dragGizmo`, { 
            method: 'POST', 
            headers: { 'Content-Type': 'application/json' }, 
            body: JSON.stringify({ x: e.movementX, y: e.movementY }) 
        }); 
    }
    
    if (isRightMouseDown) { 
        if (e.ctrlKey) {
            fetch(`https://${GetParentResourceName()}/rotateObject`, { 
                method: 'POST', 
                headers: { 'Content-Type': 'application/json' }, 
                body: JSON.stringify({ x: e.movementX, y: e.movementY }) 
            });
        } else {
            fetch(`https://${GetParentResourceName()}/rotateCamera`, { 
                method: 'POST', 
                headers: { 'Content-Type': 'application/json' }, 
                body: JSON.stringify({ x: e.movementX, y: e.movementY }) 
            }); 
        }
    }
});

document.addEventListener('wheel', (e) => { if (isMouseActive) { fetch(`https://${GetParentResourceName()}/scrollGizmo`, { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ delta: e.deltaY > 0 ? -1 : 1 }) }); } });
document.addEventListener('keydown', (e) => {
    if (isMouseActive && (e.key.toLowerCase() === 'x' || e.key === 'Escape')) { 
        fetch(`https://${GetParentResourceName()}/closeMouse`, { 
            method: 'POST', 
            headers: { 'Content-Type': 'application/json' }, 
            body: JSON.stringify({}) 
        }); 
    }

    if (e.key === 'Escape') {
        const particleModal = document.getElementById('particle-modal');
        if (particleModal && particleModal.classList.contains('visible')) {
            toggleParticleMenu(false);
            return;
        }

        const logicModal = document.getElementById('logic-modal');
        if (logicModal && logicModal.classList.contains('visible')) {
            closeSettings();
        }
    }
});

window.addEventListener('contextmenu', e => e.preventDefault());

let currentTab = 'all';
let favorites = JSON.parse(localStorage.getItem('smoke_favorites')) || [];

function toggleParticleMenu(show) {
    const el = document.getElementById('particle-modal');
    if (show) {
        el.classList.add('visible');
        switchTab('all');
        document.getElementById('particle-search').focus();
    } else {
        el.classList.remove('visible');
        fetch(`https://${GetParentResourceName()}/closeParticleMenu`, { method: 'POST' });
    }
}

function switchTab(tab) {
    currentTab = tab;  
    document.getElementById('tab-all').className = tab === 'all' ? 'tab-btn active' : 'tab-btn';
    document.getElementById('tab-fav').className = tab === 'fav' ? 'tab-btn active' : 'tab-btn';  
    document.getElementById('particle-search').value = "";
    renderParticles("", true); 
}

let currentLimit = 100;

function renderParticles(query = "", resetLimit = true) {
    const container = document.getElementById('particle-list');
    
    if (resetLimit) {
        container.innerHTML = "";
        currentLimit = (query === "") ? 100 : 400;
    } else {
        const oldBtn = document.getElementById('btn-load-more');
        if (oldBtn) oldBtn.remove();
    }
    
    let count = 0;
    const maxItems = currentLimit;
    const lowerQuery = query.toLowerCase();

    const sourceData = currentTab === 'fav' 
        ? particlesDB.filter(p => favorites.some(f => f.dict === p.dict && f.name === p.name))
        : particlesDB;

    const filteredData = sourceData.filter(p => {
        if (query === "") return true;
        const fullString = (p.dict + " " + p.name).toLowerCase();
        return fullString.includes(lowerQuery);
    });

    for (let i = 0; i < filteredData.length; i++) {
        if (i >= maxItems) break;

        const p = filteredData[i];
        const isFav = isFavorite(p.dict, p.name);
        const div = document.createElement('div');
        div.className = "particle-item";
        div.innerHTML = `
            <div class="particle-info">
                <span class="particle-name">${p.name}</span>
                <span class="particle-dict">${p.dict}</span>
            </div>
            <button class="fav-btn ${isFav ? 'active' : ''}" onclick="toggleFavorite(event, '${p.dict}', '${p.name}')">
                <svg viewBox="0 0 24 24"><path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z"/></svg>
            </button>
        `;
        
        div.onclick = (e) => {
            if(e.target.closest('.fav-btn')) return;

            fetch(`https://${GetParentResourceName()}/previewParticle`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ dict: p.dict, name: p.name })
            });

            if(inDict) inDict.value = p.dict;
            if(inName) inName.value = p.name;
        };

        div.oncontextmenu = (e) => {
            e.preventDefault();
            copyToClipboard(p.name);
            showNotification("success", "COPIED", p.name);
        };

        container.appendChild(div);
        count++;
    }
    
    if (filteredData.length > maxItems) {
        const remaining = filteredData.length - maxItems;
        const loadMoreDiv = document.createElement('div');
        loadMoreDiv.id = 'btn-load-more';
        loadMoreDiv.style.padding = "10px";
        loadMoreDiv.style.textAlign = "center";
        
        const btn = document.createElement('button');
        btn.innerText = `LOAD MORE (+${remaining > 100 ? 100 : remaining})`;
        btn.className = "btn";
        btn.style.width = "100%";
        btn.style.background = "#27272a";
        btn.style.border = "1px solid #3f3f46";
        
        btn.onclick = () => {
            currentLimit += 100;
            renderParticles(query, false);
        };
        
        loadMoreDiv.appendChild(btn);
        container.appendChild(loadMoreDiv);
    }

    if (currentTab === 'fav' && sourceData.length === 0) {
        container.innerHTML = `<div style="padding:20px; text-align:center; color:#52525b; font-size:11px;">No favorites saved yet.<br>Click the star icon to save particles.</div>`;
    } else if (filteredData.length === 0) {
        container.innerHTML = `<div style="padding:20px; text-align:center; color:#52525b; font-size:11px;">No particles found.</div>`;
    }
}

function filterParticles() {
    const txt = document.getElementById('particle-search').value;
    renderParticles(txt); 
}

// FAVORITES LOGIC

function isFavorite(dict, name) {
    return favorites.some(f => f.dict === dict && f.name === name);
}

function toggleFavorite(event, dict, name) {
    event.stopPropagation();
    
    if (isFavorite(dict, name)) {
        favorites = favorites.filter(f => !(f.dict === dict && f.name === name));
    } else {
        favorites.push({ dict, name });
    }
    
    localStorage.setItem('smoke_favorites', JSON.stringify(favorites));
    
    renderParticles(document.getElementById('particle-search').value);
}

function copyToClipboard(text) {
    const el = document.createElement('textarea');
    el.value = text;
    document.body.appendChild(el);
    el.select();
    document.execCommand('copy');
    document.body.removeChild(el);
}