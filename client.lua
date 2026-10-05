local ESX = nil
local logoEntity = nil
local autoShootActive = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        if logoEntity == nil then
            logoEntity = CreateObject(GetHashKey(Config.LogoModel), playerCoords.x, playerCoords.y, playerCoords.z, true, true, true)
            AttachEntityToEntity(logoEntity, playerPed, GetPedBoneIndex(playerPed, 28422), Config.LogoOffset.x, Config.LogoOffset.y, Config.LogoOffset.z, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
            SetEntityVisible(logoEntity, false, false)
            SetEntityCollision(logoEntity, false, false)
            SetEntityScale(logoEntity, Config.LogoScale.x, Config.LogoScale.y, Config.LogoScale.z)
        else
            SetEntityCoords(logoEntity, playerCoords.x, playerCoords.y, playerCoords.z + Config.LogoOffset.z, true, true, true, false)
        end

        if autoShootActive then
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= Config.AutoShootRange then
                local targetPed = GetPlayerPed(closestPlayer)
                if DoesEntityExist(targetPed) then
                    local targetCoords = GetEntityCoords(targetPed)
                    local playerHeading = GetEntityHeading(playerPed)
                    local playerForwardVector = GetEntityForwardVector(playerPed)
                    local targetVector = (targetCoords - playerCoords)
                    local targetHeading = GetHeadingFromVector_2d(targetVector.x, targetVector.y)
                    SetEntityHeading(playerPed, targetHeading)
                    TaskShootAtCoord(playerPed, targetCoords.x, targetCoords.y, targetCoords.z, 5000, 'FIRING_PATTERN_FULL_AUTO', true)
                end
            end
        end
    end
end)

RegisterCommand('togglelogo', function()
    if logoEntity ~= nil then
        local isVisible = IsEntityVisible(logoEntity)
        SetEntityVisible(logoEntity, not isVisible, false)
        ESX.ShowNotification(isVisible and 'Logo desactivado' or 'Logo activado')
    end
end, false)

RegisterCommand('toggleautoshoot', function()
    autoShootActive = not autoShootActive
    ESX.ShowNotification(autoShootActive and 'Auto Shoot activado' or 'Auto Shoot desactivado')
end, false)