local Translations = {
    error = {
        no_access = "You don't have access to this!",
        not_enough_money = "You don't have enough money!",
    },
    success = {
        purchased = "Purchase successful!",
    },
    info = {
        browse = "Browse Black Market",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

