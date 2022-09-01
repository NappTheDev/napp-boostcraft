local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-hackcrafting:server:craftlaptop', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    TriggerClientEvent('QBCore:Notify', src, "Successfuly crafted a boosting laptop", "success")

    if xPlayer ~= nil  then 
        for k, v in pairs(Config.LaptopRecipe) do 
            xPlayer.Functions.RemoveItem(k, v*1) 
        end

        xPlayer.Functions.AddItem(Config.BoostingLaptopDevice, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.BoostingLaptopDevice], 'add')
    end
end)

RegisterNetEvent('qb-hackcrafting:server:craftBooster', function()
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    TriggerClientEvent('QBCore:Notify', src, "Successfuly crafted a boosting device!", "success")

    if xPlayer ~= nil then
        for k, v in pairs(Config.BoostRecipe) do
            xPlayer.Functions.RemoveItem(k, v*1)
        end

        xPlayer.Functions.AddItem(Config.BoostingDevice, 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.BoostingDevice], 'add')
    end
end)

RegisterNetEvent('qb-hackcrafting:server:hasRequiredItems', function(type)
    local hasRequiredItems = true
    local xPlayer = QBCore.Functions.GetPlayer(source)

    if (type == "laptop") then
        if xPlayer ~= nil then
            for k, v in pairs(Config.LaptopRecipe) do
                if xPlayer.Functions.GetItemByName(k) == nil then
                    hasRequiredItems = false
                end
            end
        end
    else
        if xPlayer ~= nil then
            for k, v in pairs(Config.BoostRecipe) do
                if xPlayer.Functions.GetItemByName(k) == nil then
                    hasRequiredItems = false
                end
            end
        end
    end
    
    if type == "laptop" then
        if hasRequiredItems then 
            TriggerClientEvent('qb-hackcrafting:client:laptopSuccess', source) 
            return 
        end

        TriggerClientEvent('qb-hackcrafting:client:laptopFail', source)
    end
    if type == "boost" then
        if hasRequiredItems then 
            TriggerClientEvent('qb-hackcrafting:client:boostSuccess', source) 
            return 
        end

        TriggerClientEvent('qb-hackcrafting:client:boostFail', source)
    end
end)