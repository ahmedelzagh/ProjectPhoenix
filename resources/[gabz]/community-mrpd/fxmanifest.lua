fx_version 'bodacious'
game 'gta5'

author 'Community'
description 'Community MRPD'
version '1.0.0'

this_is_a_map 'yes'


data_file 'TIMECYCLEMOD_FILE' 'community_mrpd_timecycle.xml'
data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta'

files {
	'community_mrpd_timecycle.xml',
	'interiorproxies.meta'
}

client_script {
    "community_mrpd_entitysets.lua"
}