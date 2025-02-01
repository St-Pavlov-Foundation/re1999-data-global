module("modules.logic.fight.entity.comp.skill.FightTLEventEntityTexture", package.seeall)

slot0 = class("FightTLEventEntityTexture")

function slot0.handleSkillEvent(slot0, slot1, slot2, slot3)
	slot0._targetEntitys = nil

	if slot3[1] == "1" then
		slot0._targetEntitys = {}

		table.insert(slot0._targetEntitys, FightHelper.getEntity(slot1.fromId))
	elseif slot4 == "2" then
		slot0._targetEntitys = FightHelper.getSkillTargetEntitys(slot1)
	elseif not string.nilorempty(slot4) then
		if GameSceneMgr.instance:getCurScene().entityMgr:getUnit(SceneTag.UnitNpc, slot1.stepUid .. "_" .. slot4) then
			slot0._targetEntitys = {}

			table.insert(slot0._targetEntitys, slot7)
		else
			logError("找不到实体, id: " .. tostring(slot4))

			return
		end
	end

	slot0._texVariable = slot3[3]

	if not string.nilorempty(slot3[2]) then
		slot0._texturePath = ResUrl.getRoleSpineMatTex(slot5)
		slot0._loader = MultiAbLoader.New()

		slot0._loader:addPath(slot0._texturePath)
		slot0._loader:startLoad(slot0._onLoaded, slot0)
	end
end

function slot0._onLoaded(slot0, slot1)
	for slot7, slot8 in ipairs(slot0._targetEntitys) do
		slot8.spineRenderer:getReplaceMat():SetTexture(slot0._texVariable, slot1:getFirstAssetItem() and slot2:GetResource(slot0._texturePath))
	end
end

function slot0._clear(slot0)
	if not slot0._loader then
		return
	end

	slot0._loader:dispose()

	slot0._loader = nil

	for slot4, slot5 in ipairs(slot0._targetEntitys) do
		slot5.spineRenderer:getReplaceMat():SetTexture(slot0._texVariable, nil)
	end
end

function slot0.reset(slot0)
	slot0:_clear()
end

function slot0.dispose(slot0)
	slot0:_clear()
end

return slot0
