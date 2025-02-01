module("modules.logic.rouge.map.controller.RougeMapEffectHelper", package.seeall)

slot0 = class("RougeMapEffectHelper")

function slot0.checkHadEffect(slot0, slot1)
	if not RougeModel.instance:getEffectDict() then
		return false
	end

	uv0._initEffectHandle()

	if not uv0.effectHandleDict[slot0] then
		return false
	end

	for slot7, slot8 in pairs(slot2) do
		if slot8.type == slot0 and slot3(slot8, slot1) then
			return true
		end
	end

	return false
end

function slot0._initEffectHandle()
	if not uv0.effectHandleDict then
		uv0.effectHandleDict = {
			[RougeMapEnum.EffectType.UnlockRestRefresh] = uv0.defaultCheck,
			[RougeMapEnum.EffectType.UnlockFightDropRefresh] = uv0._checkUnlockFightDropRefresh,
			[RougeMapEnum.EffectType.UnlockShowPassFightMask] = uv0._checkUnlockShowPassFightMask
		}
	end
end

function slot0.defaultCheck(slot0)
	return true
end

function slot0._checkUnlockFightDropRefresh(slot0, slot1)
	return string.splitToNumber(slot0.typeParam, "#")[1] == slot1
end

function slot0._checkUnlockShowPassFightMask(slot0, slot1)
	return tonumber(slot0.typeParam) == slot1
end

return slot0
