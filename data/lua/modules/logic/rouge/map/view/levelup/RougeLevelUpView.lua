module("modules.logic.rouge.map.view.levelup.RougeLevelUpView", package.seeall)

slot0 = class("RougeLevelUpView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg")
	slot0._btnclosebtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closebtn")
	slot0._imagefaction = gohelper.findChildImage(slot0.viewGO, "Left/#image_faction")
	slot0._txtfaction = gohelper.findChildText(slot0.viewGO, "Left/#txt_faction")
	slot0._txtlevel1 = gohelper.findChildText(slot0.viewGO, "Right/level/#txt_level1")
	slot0._txtlevel2 = gohelper.findChildText(slot0.viewGO, "Right/level/#txt_level2")
	slot0._gopoint = gohelper.findChild(slot0.viewGO, "Right/volume/layout/#go_point")
	slot0._txttalen = gohelper.findChildText(slot0.viewGO, "Right/talen/#txt_talen")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclosebtn:AddClickListener(slot0._btnclosebtnOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclosebtn:RemoveClickListener()
end

function slot0._btnclosebtnOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0.pointGoList = slot0:getUserDataTb_()

	gohelper.setActive(slot0._gopoint, false)
	slot0._simagebg:LoadImage("singlebg/rouge/team/rouge_team_rolegroupbg.png")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.LvUp)

	slot0.rougeInfo = RougeModel.instance:getRougeInfo()

	slot0:refreshStyle()
	slot0:refreshLevel()
	slot0:refreshCapacity()
	slot0:refreshTalent()
	slot0:playPointAnim()
end

function slot0.refreshStyle(slot0)
	slot3 = lua_rouge_style.configDict[slot0.rougeInfo.season][slot0.rougeInfo.style]
	slot0._txtfaction.text = slot3.name

	UISpriteSetMgr.instance:setRouge2Sprite(slot0._imagefaction, string.format("%s_light", slot3.icon))
end

function slot0.refreshLevel(slot0)
	slot0._txtlevel1.text = "Lv." .. slot0.viewParam.preLv
	slot0._txtlevel2.text = "Lv." .. slot0.viewParam.curLv
end

function slot0.refreshCapacity(slot0)
	for slot6 = 1, slot0.viewParam.curTeamSize do
		slot7 = gohelper.cloneInPlace(slot0._gopoint)

		gohelper.setActive(slot7, true)

		if slot0.viewParam.preTeamSize < slot6 then
			table.insert(slot0.pointGoList, slot7)
			UISpriteSetMgr.instance:setRougeSprite(slot7:GetComponent(gohelper.Type_Image), "rouge_team_volume_light")
		else
			UISpriteSetMgr.instance:setRougeSprite(slot8, "rouge_team_volume_2")
		end
	end
end

function slot0.refreshTalent(slot0)
	slot0._txttalen.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_lv_up_talent"), {
		1
	})
end

slot0.WaitTime = 0.5

function slot0.playPointAnim(slot0)
	TaskDispatcher.cancelTask(slot0._playPointAnim, slot0)
	TaskDispatcher.runDelay(slot0._playPointAnim, slot0, uv0.WaitTime)
end

function slot0._playPointAnim(slot0)
	for slot4, slot5 in ipairs(slot0.pointGoList) do
		gohelper.setActive(gohelper.findChild(slot5, "green"), true)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._playPointAnim, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
end

return slot0
