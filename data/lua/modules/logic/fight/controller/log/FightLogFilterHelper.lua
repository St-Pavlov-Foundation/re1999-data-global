module("modules.logic.fight.controller.log.FightLogFilterHelper", package.seeall)

slot0 = _M
slot1 = {
	FightEnum.EffectType.FIGHTSTEP
}
slot2 = false

function slot0.setFilterEffectList(slot0)
	if string.nilorempty(slot0) then
		uv0 = false

		return
	end

	uv1.resetEffectFilter()
	tabletool.addValues(uv2, string.splitToNumber(slot0, ";"))

	uv0 = true
end

function slot0.resetEffectFilter()
	tabletool.clear(uv0)
	table.insert(uv0, FightEnum.EffectType.FIGHTSTEP)
end

function slot0.checkEffectMoIsFilter(slot0)
	if not uv0 then
		return false
	end

	if tabletool.indexOf(uv1, slot0.effectType) then
		return false
	end

	return true
end

return slot0
