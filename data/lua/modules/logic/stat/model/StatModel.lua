module("modules.logic.stat.model.StatModel", package.seeall)

slot0 = class("StatModel", BaseModel)

function slot0.onInit(slot0)
	slot0._basePropertiesStr = nil
	slot0._tempEventCommonProperties = nil
	slot0._roleType = ""
end

function slot0.reInit(slot0)
	slot0._basePropertiesStr = nil
	slot0._tempEventCommonProperties = nil
	slot0._roleType = ""
end

function slot0.setRoleType(slot0, slot1)
	slot0._roleType = slot1
end

function slot0.getRoleType(slot0)
	return slot0._roleType
end

function slot0.updateBaseProperties(slot0, slot1)
	slot0._basePropertiesStr = slot1
end

function slot0.getEventCommonProperties(slot0)
	slot1 = PlayerModel.instance:getPlayinfo()

	if not slot0._tempEventCommonProperties then
		slot0._tempEventCommonProperties = {
			[StatEnum.EventCommonProperties.ServerName] = LoginModel.instance.serverName,
			[StatEnum.EventCommonProperties.RoleId] = tostring(slot1.userId),
			[StatEnum.EventCommonProperties.RoleEstablishTime] = TimeUtil.timestampToString(ServerTime.timeInLocal(slot1.registerTime / 1000)),
			[StatEnum.EventCommonProperties.RoleType] = "正常"
		}
	end

	slot2 = {
		[StatEnum.EventCommonProperties.RoleName] = slot1.name,
		[StatEnum.EventCommonProperties.GiveCurrencyNum] = slot4,
		[StatEnum.EventCommonProperties.PaidCurrencyNum] = slot3,
		[StatEnum.EventCommonProperties.CurrencyNum] = slot3 + slot4,
		[StatEnum.EventCommonProperties.RoleLevel] = slot1.level,
		[StatEnum.EventCommonProperties.CurrentProgress] = DungeonConfig.instance:getEpisodeCO(slot1.lastEpisodeId) and tostring(slot5.name .. slot5.id) or "",
		[slot10] = slot11
	}
	slot3 = CurrencyModel.instance:getDiamond()
	slot4 = CurrencyModel.instance:getFreeDiamond()

	for slot10, slot11 in pairs(slot0._tempEventCommonProperties) do
		-- Nothing
	end

	if not LoginModel.instance:isDoneLogin() then
		slot0._tempEventCommonProperties = nil
	end

	return slot2
end

function slot0.generateRoleInfo(slot0)
	slot2 = cjson.encode(PayModel.instance:getGameRoleInfo())

	logNormal(slot2)

	return slot2
end

function slot0.getPayInfo(slot0)
	slot2 = cjson.encode(PayModel.instance:getGamePayInfo())

	logNormal("Pay Info " .. slot2)

	return slot2
end

slot0.instance = slot0.New()

return slot0
