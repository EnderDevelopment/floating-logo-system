local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('floating_logo_system:getSettings', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        MySQL.Async.fetchScalar('SELECT logo_enabled FROM floating_logo_settings WHERE player_id = @player_id', {
            ['@player_id'] = xPlayer.identifier
        }, function(logoEnabled)
            if logoEnabled == nil then
                MySQL.Async.execute('INSERT INTO floating_logo_settings (player_id, logo_enabled, auto_shoot_enabled) VALUES (@player_id, FALSE, FALSE)', {
                    ['@player_id'] = xPlayer.identifier
                }, function()
                    cb({logoEnabled = false, autoShootEnabled = false})
                end)
            else
                MySQL.Async.fetchScalar('SELECT auto_shoot_enabled FROM floating_logo_settings WHERE player_id = @player_id', {
                    ['@player_id'] = xPlayer.identifier
                }, function(autoShootEnabled)
                    cb({logoEnabled = logoEnabled, autoShootEnabled = autoShootEnabled})
                end)
            end
        end)
    else
        cb({logoEnabled = false, autoShootEnabled = false})
    end
end)

RegisterServerEvent('floating_logo_system:updateSettings')
AddEventHandler('floating_logo_system:updateSettings', function(logoEnabled, autoShootEnabled)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        MySQL.Async.execute('UPDATE floating_logo_settings SET logo_enabled = @logo_enabled, auto_shoot_enabled = @auto_shoot_enabled WHERE player_id = @player_id', {
            ['@player_id'] = xPlayer.identifier,
            ['@logo_enabled'] = logoEnabled,
            ['@auto_shoot_enabled'] = autoShootEnabled
        })
    end
end)