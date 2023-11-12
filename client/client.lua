ESX = exports["es_extended"]:getSharedObject()

RegisterCommand("report", function(source, args, rawCommand)
    local src = source
  
    local input = lib.inputDialog('Rapporter afspillermenu', {
        {type = 'number', label = 'ID Player', icon = 'user'},
        {type = 'input', label = 'Reason', icon = 'comment'},
        
    })

    if input then
        local IdGiocatore = tonumber(input[1])
        local motivo = input[2]

        if IdGiocatore == nil then
            TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = "Sørg for at inkludere et spiller-id.", 6000})
        elseif motivo == nil then
            TriggerClientEvent('ox_lib:notify', src, {type = 'error', description = "Sørg for at inkludere en årsag.", 6000})
        else
            TriggerServerEvent("Kigo_Reports:ReportPlayers", Spiller-id, grund)
        end
    end
end, false)

