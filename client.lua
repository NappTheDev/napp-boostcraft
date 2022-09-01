local QBCore = exports['qb-core']:GetCoreObject()

-- Zones
exports['qb-target']:AddBoxZone("HackCrafting", vector3(-512.77, -1746.92, 19.1), 1, 1, {
    name = "HackCrafting",
    heading = 55,
    debugPoly = false,
    minZ = 18.1,
    maxZ = 20.7,
}, {
    options = {
        {
            type = "client",
            event = "qb-hackcrafting:client:craftLaptop",
            icon = "fas fa-hand-back-fist",
            label = "Craft Laptop",
        },
    },
    distance = 2.5
})

exports['qb-target']:AddBoxZone("boostCraft", vector3(1122.72, -1305.34, 34.72), 1, 2.5, {
    name = "boostCraft",
    heading = 0,
    debugPoly = false,
    minZ = 33.72,
    maxZ = 36.12,
}, {
    options = {
        {
            type = "client",
            event = "qb-hackcrafting:client:craftBoostingDevice",
            icon = "fas fa-hand-back-fist",
            label = "Craft Boosting Device",
        },
    },
    distance = 2.5
})

RegisterNetEvent('qb-hackcrafting:client:craftLaptop', function()
    TriggerServerEvent('qb-hackcrafting:server:hasRequiredItems', "laptop")
end)

RegisterNetEvent('qb-hackcrafting:client:laptopSuccess', function()
    local ped = PlayerPedId()
    local PlayerData = QBCore.Functions.GetPlayerData()

    TriggerEvent('QBCore:Notify', "Crafting a boosting laptop!", "success")

    QBCore.Functions.Progressbar('crafting', "Are you sure you know what you're doing?", 5000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'mp_car_bomb',
        anim = 'car_bomb_mechanic',
        flags = 2,
    }, {}, {}, function() -- Play When Done
        ClearPedTasks(ped)
        TriggerServerEvent('qb-hackcrafting:server:craftlaptop')
    end, function() -- Play When Cancel
        ClearPedTasks(ped)
        TriggerEvent('QBCore:Notify', 'Error: Cancelled', "error")
    end)
end)

RegisterNetEvent('qb-hackcrafting:client:laptopFail', function()
    TriggerEvent('QBCore:Notify', "You do not have all the required items to craft a boosting laptop!", "error")
end)

-- Boosting Device
RegisterNetEvent('qb-hackcrafting:client:craftBoostingDevice', function()
    TriggerServerEvent('qb-hackcrafting:server:hasRequiredItems', "boost")
end)

RegisterNetEvent('qb-hackcrafting:client:boostSuccess', function()
    local ped = PlayerPedId()
    local PlayerData = QBCore.Functions.GetPlayerData()

    TriggerEvent('QBCore:Notify', "Crafting a boosting device!", "success")

    QBCore.Functions.Progressbar('crafting', "Whatcha doin?", 5000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'mp_car_bomb',
        anim = 'car_bomb_mechanic',
        flags = 2,
    }, {}, {}, function() -- Play When Done
        ClearPedTasks(ped)
        TriggerServerEvent('qb-hackcrafting:server:craftBooster')
    end, function() -- Play When Cancel
        ClearPedTasks(ped)
        TriggerEvent('QBCore:Notify', 'Error: Cancelled', "error")
    end)
end)

RegisterNetEvent('qb-hackcrafting:client:boostFail', function()
    TriggerEvent('QBCore:Notify', "You do not have all the required items to craft a boosting device!", "error")
end)
