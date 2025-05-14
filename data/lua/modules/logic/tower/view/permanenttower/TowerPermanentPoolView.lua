module("modules.logic.tower.view.permanenttower.TowerPermanentPoolView", package.seeall)

local var_0_0 = class("TowerPermanentPoolView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goPoolContent = gohelper.findChild(arg_1_0.viewGO, "Left/#go_altitudePool")
	arg_1_0._goaltitudeItem = gohelper.findChild(arg_1_0.viewGO, "Left/#go_altitudePool/#go_altitudeItem")
	arg_1_0._goeliteItem = gohelper.findChild(arg_1_0.viewGO, "episode/#go_eliteEpisode/#go_eliteItem")
	arg_1_0._goEliteEpisodeContent = gohelper.findChild(arg_1_0.viewGO, "episode/#go_eliteEpisode/#go_eliteEpisodeContent")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0.altitudeItemPoolTab = arg_2_0:getUserDataTb_()
	arg_2_0.altitudeItemPoolList = arg_2_0:getUserDataTb_()

	gohelper.setActive(arg_2_0._goPoolContent, false)
	gohelper.setActive(arg_2_0._goeliteItem, false)
	recthelper.setAnchorX(arg_2_0._goPoolContent.transform, -10000)

	arg_2_0.eliteEpisodeItemPoolTab = arg_2_0:getUserDataTb_()
	arg_2_0.eliteEpisodeItemPoolList = arg_2_0:getUserDataTb_()

	gohelper.setActive(arg_2_0._goEliteEpisodeContent, false)
end

function var_0_0.createOrGetAltitudeItem(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_0.altitudeItemPoolTab[arg_3_1.index]

	if not var_3_0 then
		var_3_0 = {
			go = gohelper.clone(arg_3_0._goaltitudeItem, arg_3_0._goPoolContent, "altitude" .. arg_3_1.index)
		}
		var_3_0.itemCanvasGroup = gohelper.findChild(var_3_0.go, "item"):GetComponent(gohelper.Type_CanvasGroup)
		var_3_0.goNormal = gohelper.findChild(var_3_0.go, "item/go_normal")
		var_3_0.goNormalSelect = gohelper.findChild(var_3_0.go, "item/go_normal/go_select")
		var_3_0.goNormalUnFinish = gohelper.findChild(var_3_0.go, "item/go_normal/go_unfinish")
		var_3_0.goNormalFinish = gohelper.findChild(var_3_0.go, "item/go_normal/go_finish")
		var_3_0.animNormalFinish = var_3_0.goNormalFinish:GetComponent(gohelper.Type_Animator)
		var_3_0.goNormalLock = gohelper.findChild(var_3_0.go, "item/go_normal/go_lock")
		var_3_0.goElite = gohelper.findChild(var_3_0.go, "item/go_elite")
		var_3_0.goEliteSelect = gohelper.findChild(var_3_0.go, "item/go_elite/go_select")
		var_3_0.goEliteUnFinish = gohelper.findChild(var_3_0.go, "item/go_elite/go_unfinish")
		var_3_0.goEliteFinish = gohelper.findChild(var_3_0.go, "item/go_elite/go_finish")
		var_3_0.animEliteFinish = var_3_0.goEliteFinish:GetComponent(gohelper.Type_Animator)
		var_3_0.goEliteLock = gohelper.findChild(var_3_0.go, "item/go_elite/go_lock")
		var_3_0.goArrow = gohelper.findChild(var_3_0.go, "go_arrow/arrow")
		var_3_0.goReward = gohelper.findChild(var_3_0.go, "go_arrow/Reward/image_RewardBG")
		var_3_0.simageReward = gohelper.findChildSingleImage(var_3_0.go, "go_arrow/Reward/image_RewardBG/simage_reward")
		var_3_0.txtNum = gohelper.findChildText(var_3_0.go, "item/txt_num")
		var_3_0.btnClick = gohelper.findChildButtonWithAudio(var_3_0.go, "btn_click")
		arg_3_0.altitudeItemPoolTab[arg_3_1.index] = var_3_0

		table.insert(arg_3_0.altitudeItemPoolList, var_3_0)
	end

	var_3_0.btnClick:AddClickListener(arg_3_2, arg_3_3, arg_3_1)

	return var_3_0
end

function var_0_0.recycleAltitudeItem(arg_4_0, arg_4_1)
	for iter_4_0 = #arg_4_1 + 1, #arg_4_0.altitudeItemPoolList do
		if arg_4_0.altitudeItemPoolList[iter_4_0] then
			gohelper.setActive(arg_4_0.altitudeItemPoolList[iter_4_0].go, false)
			arg_4_0.altitudeItemPoolList[iter_4_0].go.transform:SetParent(arg_4_0._goPoolContent.transform, false)
			recthelper.setAnchor(arg_4_0.altitudeItemPoolList[iter_4_0].go.transform, 0, 0)
		end
	end
end

function var_0_0.getaltitudeItemPoolList(arg_5_0)
	return arg_5_0.altitudeItemPoolList, arg_5_0.altitudeItemPoolTab
end

function var_0_0.createOrGetEliteEpisodeItem(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0.eliteEpisodeItemPoolTab[arg_6_1]

	if not var_6_0 then
		var_6_0 = {
			go = gohelper.clone(arg_6_0._goeliteItem, arg_6_0._goEliteEpisodeContent, "eliteItem" .. arg_6_1)
		}
		var_6_0.imageIcon = gohelper.findChildImage(var_6_0.go, "image_icon")
		var_6_0.goSelect = gohelper.findChild(var_6_0.go, "go_select")
		var_6_0.imageSelectIcon = gohelper.findChildImage(var_6_0.go, "go_select/image_selectIcon")
		var_6_0.imageSelectFinishIcon = gohelper.findChildImage(var_6_0.go, "go_select/image_selectFinishIcon")
		var_6_0.goFinish = gohelper.findChild(var_6_0.go, "go_finish")
		var_6_0.goFinishEffect = gohelper.findChild(var_6_0.go, "go_finishEffect")
		var_6_0.imageFinishIcon = gohelper.findChildImage(var_6_0.go, "go_finish/image_finishIcon")
		var_6_0.txtName = gohelper.findChildText(var_6_0.go, "txt_name")
		var_6_0.btnClick = gohelper.findChildButtonWithAudio(var_6_0.go, "btn_click")
		var_6_0.isSelect = false
		var_6_0.episodeIndex = arg_6_1
		arg_6_0.eliteEpisodeItemPoolTab[arg_6_1] = var_6_0

		table.insert(arg_6_0.eliteEpisodeItemPoolList, var_6_0)
	end

	var_6_0.btnClick:AddClickListener(arg_6_2, arg_6_3, arg_6_1)

	return var_6_0
end

function var_0_0.recycleEliteEpisodeItem(arg_7_0, arg_7_1)
	for iter_7_0 = #arg_7_1 + 1, #arg_7_0.eliteEpisodeItemPoolList do
		if arg_7_0.eliteEpisodeItemPoolList[iter_7_0] then
			gohelper.setActive(arg_7_0.eliteEpisodeItemPoolList[iter_7_0].go, false)
			arg_7_0.eliteEpisodeItemPoolList[iter_7_0].go.transform:SetParent(arg_7_0._goEliteEpisodeContent.transform, false)
			recthelper.setAnchor(arg_7_0.eliteEpisodeItemPoolList[iter_7_0].go.transform, 0, 0)
		end
	end
end

function var_0_0.getEliteEpisodeItemPoolList(arg_8_0)
	return arg_8_0.eliteEpisodeItemPoolList, arg_8_0.eliteEpisodeItemPoolTab
end

function var_0_0.onClose(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.altitudeItemPoolTab) do
		iter_9_1.btnClick:RemoveClickListener()
		iter_9_1.simageReward:UnLoadImage()
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_0.eliteEpisodeItemPoolList) do
		iter_9_3.btnClick:RemoveClickListener()
	end
end

return var_0_0
