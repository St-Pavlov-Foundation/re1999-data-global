module("modules.logic.gm.view.GMFightEntitySkillView", package.seeall)

slot0 = class("GMFightEntitySkillView", BaseView)

function slot0.onInitView(slot0)
	slot0._input = gohelper.findChildTextMeshInputField(slot0.viewGO, "skill/add/input")
	slot0._btnAdd = gohelper.findChildButton(slot0.viewGO, "skill/add/btnAdd")
end

function slot0.addEvents(slot0)
	slot0._btnAdd:AddClickListener(slot0._onClickAddSkill, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnAdd:RemoveClickListener()
end

function slot0._onClickAddSkill(slot0)
	slot1 = tonumber(slot0._input:GetText())
	slot2 = lua_skill.configDict[slot1]

	if tabletool.indexOf(GMFightEntityModel.instance.entityMO.skillList, slot1) then
		GameFacade.showToast(ToastEnum.IconId, "skill has exist")
	elseif slot2 then
		GMRpc.instance:sendGMRequest(string.format("fightAddPassiveSkill %s %s", tostring(slot3.id), tostring(slot1)))
		slot3:addPassiveSkill(slot1)
		GMFightEntityModel.instance:setEntityMO(slot3)

		if FightLocalDataMgr.instance.entityMgr:getById(slot3.id) then
			FightEntityDataHelper.copyEntityMO(slot3, slot4)
		end
	else
		GameFacade.showToast(ToastEnum.IconId, "skill not exist")
	end
end

return slot0
