module("modules.logic.toughbattle.view.ToughBattleSkillView", package.seeall)

slot0 = class("ToughBattleSkillView", BaseView)

function slot0.onInitView(slot0)
	slot0._simgrole = gohelper.findChildSingleImage(slot0.viewGO, "root/view/role/#simage_role")
	slot0._txttitle = gohelper.findChildTextMesh(slot0.viewGO, "root/view/title/titletxt")
	slot0._txtskilldes = gohelper.findChildTextMesh(slot0.viewGO, "root/view/#txt_desc")
	slot0._txtnormaldes = gohelper.findChildTextMesh(slot0.viewGO, "root/view/#txt_desc/#txt_desc2")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/view/#btn_closebtn")
	slot0._goBuffContainer = gohelper.findChild(slot0.viewGO, "root/#go_buffContainer")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goBuffContainer, false)
end

function slot0.onOpen(slot0)
	slot0:refreshSkillInfo(slot0.viewParam.showCo)

	if slot0.viewParam.isShowList then
		slot0:createAndSelect()
	end
end

function slot0.createAndSelect(slot0)
	slot2 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer._viewSetting.otherRes.rolelist, slot0.viewGO, "rolelist"), ToughBattleRoleListComp, slot0.viewParam)

	slot2:setClickCallBack(slot0.onRoleSelect, slot0)

	slot0._roleList = slot2

	slot2:setSelect(slot0.viewParam.showCo)
end

function slot0.onRoleSelect(slot0, slot1)
	slot0:refreshSkillInfo(slot1)
	slot0._roleList:setSelect(slot1)
end

function slot0.refreshSkillInfo(slot0, slot1)
	slot0._simgrole:LoadImage("singlebg/toughbattle_singlebg/role/rolehalfpic" .. slot1.sort .. ".png")

	if not lua_siege_battle_hero.configDict[slot1.heroId] then
		logError("no hero co" .. slot1.heroId)
	else
		slot0._txttitle.text = slot2.name
		slot0._txtskilldes.text = slot2.desc
	end

	slot0._txtnormaldes.text = slot1.instructionDesc
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.onDestroyView(slot0)
	slot0._simgrole:UnLoadImage()
end

return slot0
