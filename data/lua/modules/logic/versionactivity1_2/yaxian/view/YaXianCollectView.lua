module("modules.logic.versionactivity1_2.yaxian.view.YaXianCollectView", package.seeall)

slot0 = class("YaXianCollectView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._btncloseView = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeview")
	slot0._simageblackbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_blackbg")
	slot0._gonodeitem = gohelper.findChild(slot0.viewGO, "#simage_blackbg/#scroll_reward/Viewport/#go_content/#go_nodeitem")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#simage_blackbg/#btn_close")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#simage_blackbg/bottom/#txt_num")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btncloseView:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btncloseView:RemoveClickListener()
end

slot0.IndexColor = {
	Had = GameUtil.parseColor("#EDFFDD"),
	NotHad = GameUtil.parseColor("#86907E")
}
slot0.DescColor = {
	Had = GameUtil.parseColor("#A3AB9C"),
	NotHad = GameUtil.parseColor("#7C8376")
}

function slot0._btncloseviewOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnrepalyOnClick(slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.btnReplayClick(slot0, slot1)
	if YaXianModel.instance:hadTooth(slot1.toothConfig.id) then
		StoryController.instance:playStory(slot1.toothConfig.story)
	end
end

function slot0._editableInitView(slot0)
	slot0._goScroll = gohelper.findChild(slot0.viewGO, "#simage_blackbg/#scroll_reward")

	slot0._simagebg:LoadImage(ResUrl.getYaXianImage("img_deco_zhizhuwang"))
	slot0._simageblackbg:LoadImage(ResUrl.getYaXianImage("img_tanchuang_bg"))

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._goScroll)

	slot0._drag:AddDragBeginListener(slot0._onDragBeginHandler, slot0)
	gohelper.setActive(slot0._gonodeitem, false)

	slot0.toothItemList = {}
end

function slot0._onDragBeginHandler(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_swath_open)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.totalToothCount = #lua_activity115_tooth.configList
	slot0._txtnum.text = YaXianModel.instance:getHadToothCount() - 1 .. "/" .. slot0.totalToothCount - 1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	for slot4, slot5 in ipairs(lua_activity115_tooth.configList) do
		slot0:createToothItem().toothConfig = slot5

		if slot5.id == 0 then
			slot0.zeroToothItem = slot6
		end

		gohelper.setActive(slot6.go, true)
		gohelper.setActive(slot6.goRightLine, slot0.totalToothCount ~= slot4)

		slot7 = YaXianModel.instance:hadTooth(slot5.id)

		gohelper.setActive(slot6.goTooth, slot7)
		gohelper.setActive(slot6.goNone, not slot7)

		slot6.txtIndex.text = string.format("%02d", slot5.id)
		slot6.txtIndex.color = slot7 and uv0.IndexColor.Had or uv0.IndexColor.NotHad
		slot6.txtDesc.color = slot7 and uv0.DescColor.Had or uv0.DescColor.NotHad

		if slot7 then
			slot6.txtDesc.text = slot5.desc
			slot6.txtName.text = slot5.name

			slot0:loadToothIcon(slot6)

			slot8 = YaXianConfig.instance:getToothUnlockSkill(slot5.id)

			gohelper.setActive(slot6.goUnLockSkill, slot8)

			if slot8 then
				slot6.txtUnLockSkill.text = luaLang("versionactivity_1_2_yaxian_unlock_skill_" .. slot8)
			end

			slot6.txtUp.text = string.format(luaLang("versionactivity_1_2_yaxian_up_to_level"), HeroConfig.instance:getCommonLevelDisplay(lua_hero_trial.configDict[YaXianEnum.HeroTrialId][YaXianConfig.instance:getToothUnlockHeroTemplate(slot5.id)] and slot10.level or 0))
		else
			slot6.txtDesc.text = luaLang("versionactivity_1_2_yaxian_not_found_tooth")
		end
	end
end

function slot0.loadToothIcon(slot0, slot1)
	if slot1.toothConfig.id ~= 0 then
		slot1.toothIcon:LoadImage(ResUrl.getYaXianImage(slot2.icon))

		return
	end

	slot1.toothIcon:LoadImage(ResUrl.getYaXianImage(slot2.icon), slot0.loadImageDone, slot0)

	slot4 = slot1.toothIcon.gameObject.transform
	slot4.anchorMin = RectTransformDefine.Anchor.CenterMiddle
	slot4.anchorMax = RectTransformDefine.Anchor.CenterMiddle

	recthelper.setAnchor(slot4, 0, 0)

	slot4.parent:GetComponent(typeof(UnityEngine.UI.Image)).enabled = false
end

function slot0.loadImageDone(slot0)
	if slot0.zeroToothItem then
		slot0.zeroToothItem.toothIcon.gameObject:GetComponent(typeof(UnityEngine.UI.Image)):SetNativeSize()
	end
end

function slot0.createToothItem(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.cloneInPlace(slot0._gonodeitem)
	slot1.goTooth = gohelper.findChild(slot1.go, "go_tooth")
	slot1.goNone = gohelper.findChild(slot1.go, "go_none")
	slot1.txtIndex = gohelper.findChildText(slot1.go, "txt_index")
	slot1.txtDesc = gohelper.findChildText(slot1.go, "#scroll_desc/Viewport/Content/txt_desc")
	slot1.goRightLine = gohelper.findChild(slot1.go, "line")
	slot1._scrolldesc = gohelper.findChild(slot1.go, "#scroll_desc"):GetComponent(typeof(ZProj.LimitedScrollRect))
	slot1.toothIcon = gohelper.findChildSingleImage(slot1.go, "go_tooth/icon_bg/tooth_icon")
	slot1.txtName = gohelper.findChildText(slot1.go, "go_tooth/middle/txt_name")
	slot1.goUnLockSkill = gohelper.findChild(slot1.go, "go_tooth/middle/go_unlockskill")
	slot1.txtUnLockSkill = gohelper.findChildText(slot1.go, "go_tooth/middle/go_unlockskill/txt_unlockskill")
	slot1.txtUp = gohelper.findChildText(slot1.go, "go_tooth/middle/txt_up")
	slot1.btnReplay = gohelper.findChildButtonWithAudio(slot1.go, "go_tooth/bottom/btn_replay")

	slot1.btnReplay:AddClickListener(slot0.btnReplayClick, slot0, slot1)

	slot1._scrolldesc.parentGameObject = slot0._goScroll

	table.insert(slot0.toothItemList, slot1)

	return slot1
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simageblackbg:UnLoadImage()
	slot0._drag:RemoveDragBeginListener()

	slot0._drag = nil

	for slot4, slot5 in ipairs(slot0.toothItemList) do
		slot5.btnReplay:RemoveClickListener()
		slot5.toothIcon:UnLoadImage()
	end
end

return slot0
