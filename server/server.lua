ESX = exports["es_extended"]:getSharedObject()

CreateThread(function()
    print("██   ██ ██  ██████   ██████  ")
    print("██  ██  ██ ██       ██    ██ ")
    print("█████   ██ ██   ███ ██    ██ ")
    print("██  ██  ██ ██    ██ ██    ██ ")
    print("██   ██ ██  ██████   ██████  ")
    print('^8Kigo_Reports initialized^0')
end)


RegisterNetEvent("Kigo_reports:ReportPlayers")
AddEventHandler("Kigo_reports:ReportPlayers", function(IdGiocatore, motivo)
    local src = source
    local name = GetPlayerName(src)
    local IdSteamDiscord = ExtractIdentifiers(IdGiocatore)
    local steam = IdSteamDiscord.steam:gsub("steam:", "")
    local steamDec = tostring(tonumber(steam, 16))
    steam = "https://steamcommunity.com/profiles/" .. steamDec
    local gameLicense = IdSteamDiscord.license
    local discord = IdSteamDiscord.discord

    if IdGiocatore == nil or motivo == nil then
        return
    end

    if GetPlayerIdentifiers(IdGiocatore)[1] == nil then
        TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = "Den rapporterede spiller er ikke online.", 6000})
        return
    end
    TriggerClientEvent('ox_lib:notify', src, {type = 'success', description = "Tak fordi du har indsendt en rapport! Personalet vil være hos dig inden længe.", 6000})

    local players = GetAllPlayers()
    for i = 1, #players do
        if IsPlayerAceAllowed(players[i], "Kigo_reports.view") then
            TriggerClientEvent('esx:showNotification', players[i], "Player [" .. IdGiocatore .. "] [" .. GetPlayerName(IdGiocatore) .. "] er blevet rapporteret af: [" .. src .. "] " .. name .. " for: " .. motivo)
        end
    end

    sendToDisc(
        "Player [" .. IdGiocatore .. "] [" .. GetPlayerName(IdGiocatore) .. "] Er blevet anmeldt..",
        "**Motivo**: ``" .. motivo .. "``" ..
            "\n**Game License:** ``" .. gameLicense ..
            "``\n**Discord UID:** ``" .. discord:gsub('discord:', '') ..
            "``\n**Discord-Tag:** <@!" .. discord:gsub('discord:', '') .. ">" ..
            "\n**Steam:** " .. steam,
        "Reported by: [" .. src .. "] " .. name
    )
end)


-- Functions
function sendToDisc(title, msg, fmsg)
    local embed = {
        {
            ["color"] = 1027569,
            ["title"] = "**".. title .."**",
            ["description"] = msg,
            ["footer"] = {
                ["text"] = fmsg,
                ["icon_url"] = "https://media.discordapp.net/attachments/1052910824865402892/1129370368969285632/Kigo-logo.png",
            },
        }
    }
    PerformHttpRequest(Kigo.DiscordWebhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end

function GetAllPlayers()
    local players = {}

    for _, i in ipairs(GetPlayers()) do
        table.insert(players, i)    
    end

    return players
end


-- Function to extract player identifiers
function ExtractIdentifiers(src)
    -- Initialize an empty table to store the identifiers
    local identifiers = {
        steam = "",     -- Steam identifier
        ip = "",        -- IP address
        discord = "",   -- Discord identifier
        license = "",   -- Game license
    }

    -- Loop through the player's identifiers and assign them to the corresponding entry in the 'identifiers' table
    for i = 0, GetNumPlayerIdentifiers(src) - 1 do
        local id = GetPlayerIdentifier(src, i)

        -- Check the type of identifier and assign it to the appropriate entry in the table
        if string.find(id, "steam") then
            identifiers.steam = id
        elseif string.find(id, "ip") then
            identifiers.ip = id
        elseif string.find(id, "discord") then
            identifiers.discord = id
        elseif string.find(id, "license") then
            identifiers.license = id
        end
    end

    -- Return the table containing the player's identifiers organized by type
    return identifiers
end
