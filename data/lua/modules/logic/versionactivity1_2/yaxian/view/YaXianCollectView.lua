module("modules.logic.versionactivity1_2.yaxian.view.YaXianCollectView", package.seeall)

local var_0_0 = class("YaXianCollectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._btncloseView = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeview")
	arg_1_0._simageblackbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_blackbg")
	arg_1_0._gonodeitem = gohelper.findChild(arg_1_0.viewGO, "#simage_blackbg/#scroll_reward/Viewport/#go_content/#go_nodeitem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#simage_blackbg/#btn_close")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#simage_blackbg/bottom/#txt_num")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btncloseView:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btncloseView:RemoveClickListener()
end

var_0_0.IndexColor = {
	Had = GameUtil.parseColor("#EDFFDD"),
	NotHad = GameUtil.parseColor("#86907E")
}
var_0_0.DescColor = {
	Had = GameUtil.parseColor("#A3AB9C"),
	NotHad = GameUtil.parseColor("#7C8376")
}

function var_0_0._btncloseviewOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnrepalyOnClick(arg_5_0)
	return
end

function var_0_0._btncloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0.btnReplayClick(arg_7_0, arg_7_1)
	if YaXianModel.instance:hadTooth(arg_7_1.toothConfig.id) then
		StoryController.instance:playStory(arg_7_1.toothConfig.story)
	end
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._goScroll = gohelper.findChild(arg_8_0.viewGO, "#simage_blackbg/#scroll_reward")

	arg_8_0._simagebg:LoadImage(ResUrl.getYaXianImage("img_deco_zhizhuwang"))
	arg_8_0._simageblackbg:LoadImage(ResUrl.getYaXianImage("img_tanchuang_bg"))

	arg_8_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_8_0._goScroll)

	arg_8_0._drag:AddDragBeginListener(arg_8_0._onDragBeginHandler, arg_8_0)
	gohelper.setActive(arg_8_0._gonodeitem, false)

	arg_8_0.toothItemList = {}
end

function var_0_0._onDragBeginHandler(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_swath_open)
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0.totalToothCount = #lua_activity115_tooth.configList
	arg_11_0._txtnum.text = YaXianModel.instance:getHadToothCount() - 1 .. "/" .. arg_11_0.totalToothCount - 1

	arg_11_0:refreshUI()
end

function var_0_0.refreshUI(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(lua_activity115_tooth.configList) do
		local var_12_0 = arg_12_0:createToothItem()

		var_12_0.toothConfig = iter_12_1

		if iter_12_1.id == 0 then
			arg_12_0.zeroToothItem = var_12_0
		end

		gohelper.setActive(var_12_0.go, true)
		gohelper.setActive(var_12_0.goRightLine, arg_12_0.totalToothCount ~= iter_12_0)

		local var_12_1 = YaXianModel.instance:hadTooth(iter_12_1.id)

		gohelper.setActive(var_12_0.goTooth, var_12_1)
		gohelper.setActive(var_12_0.goNone, not var_12_1)

		var_12_0.txtIndex.text = string.format("%02d", iter_12_1.id)
		var_12_0.txtIndex.color = var_12_1 and var_0_0.IndexColor.Had or var_0_0.IndexColor.NotHad
		var_12_0.txtDesc.color = var_12_1 and var_0_0.DescColor.Had or var_0_0.DescColor.NotHad

		if var_12_1 then
			var_12_0.txtDesc.text = iter_12_1.desc
			var_12_0.txtName.text = iter_12_1.name

			arg_12_0:loadToothIcon(var_12_0)

			local var_12_2 = YaXianConfig.instance:getToothUnlockSkill(iter_12_1.id)

			gohelper.setActive(var_12_0.goUnLockSkill, var_12_2)

			if var_12_2 then
				var_12_0.txtUnLockSkill.text = luaLang("versionactivity_1_2_yaxian_unlock_skill_" .. var_12_2)
			end

			local var_12_3 = YaXianConfig.instance:getToothUnlockHeroTemplate(iter_12_1.id)
			local var_12_4 = lua_hero_trial.configDict[YaXianEnum.HeroTrialId][var_12_3]
			local var_12_5 = HeroConfig.instance:getCommonLevelDisplay(var_12_4 and var_12_4.level or 0)

			var_12_0.txtUp.text = string.format(luaLang("versionactivity_1_2_yaxian_up_to_level"), var_12_5)
		else
			var_12_0.txtDesc.text = luaLang("versionactivity_1_2_yaxian_not_found_tooth")
		end
	end
end

function var_0_0.loadToothIcon(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.toothConfig

	if var_13_0.id ~= 0 then
		arg_13_1.toothIcon:LoadImage(ResUrl.getYaXianImage(var_13_0.icon))

		return
	end

	arg_13_1.toothIcon:LoadImage(ResUrl.getYaXianImage(var_13_0.icon), arg_13_0.loadImageDone, arg_13_0)

	local var_13_1 = arg_13_1.toothIcon.gameObject.transform

	var_13_1.anchorMin = RectTransformDefine.Anchor.CenterMiddle
	var_13_1.anchorMax = RectTransformDefine.Anchor.CenterMiddle

	recthelper.setAnchor(var_13_1, 0, 0)

	var_13_1.parent:GetComponent(typeof(UnityEngine.UI.Image)).enabled = false
end

function var_0_0.loadImageDone(arg_14_0)
	if arg_14_0.zeroToothItem then
		arg_14_0.zeroToothItem.toothIcon.gameObject:GetComponent(typeof(UnityEngine.UI.Image)):SetNativeSize()
	end
end

function var_0_0.createToothItem(arg_15_0)
	local var_15_0 = arg_15_0:getUserDataTb_()

	var_15_0.go = gohelper.cloneInPlace(arg_15_0._gonodeitem)
	var_15_0.goTooth = gohelper.findChild(var_15_0.go, "go_tooth")
	var_15_0.goNone = gohelper.findChild(var_15_0.go, "go_none")
	var_15_0.txtIndex = gohelper.findChildText(var_15_0.go, "txt_index")
	var_15_0.txtDesc = gohelper.findChildText(var_15_0.go, "#scroll_desc/Viewport/Content/txt_desc")
	var_15_0.goRightLine = gohelper.findChild(var_15_0.go, "line")
	var_15_0._scrolldesc = gohelper.findChild(var_15_0.go, "#scroll_desc"):GetComponent(typeof(ZProj.LimitedScrollRect))
	var_15_0.toothIcon = gohelper.findChildSingleImage(var_15_0.go, "go_tooth/icon_bg/tooth_icon")
	var_15_0.txtName = gohelper.findChildText(var_15_0.go, "go_tooth/middle/txt_name")
	var_15_0.goUnLockSkill = gohelper.findChild(var_15_0.go, "go_tooth/middle/go_unlockskill")
	var_15_0.txtUnLockSkill = gohelper.findChildText(var_15_0.go, "go_tooth/middle/go_unlockskill/txt_unlockskill")
	var_15_0.txtUp = gohelper.findChildText(var_15_0.go, "go_tooth/middle/txt_up")
	var_15_0.btnReplay = gohelper.findChildButtonWithAudio(var_15_0.go, "go_tooth/bottom/btn_replay")

	var_15_0.btnReplay:AddClickListener(arg_15_0.btnReplayClick, arg_15_0, var_15_0)

	var_15_0._scrolldesc.parentGameObject = arg_15_0._goScroll

	table.insert(arg_15_0.toothItemList, var_15_0)

	return var_15_0
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	arg_17_0._simagebg:UnLoadImage()
	arg_17_0._simageblackbg:UnLoadImage()
	arg_17_0._drag:RemoveDragBeginListener()

	arg_17_0._drag = nil

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.toothItemList) do
		iter_17_1.btnReplay:RemoveClickListener()
		iter_17_1.toothIcon:UnLoadImage()
	end
end

return var_0_0
