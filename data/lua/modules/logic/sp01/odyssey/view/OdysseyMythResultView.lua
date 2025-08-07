module("modules.logic.sp01.odyssey.view.OdysseyMythResultView", package.seeall)

local var_0_0 = class("OdysseyMythResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._click = gohelper.getClick(arg_1_0.viewGO)
	arg_1_0._imagerecord = gohelper.findChildImage(arg_1_0.viewGO, "root/Left/go_level/#image_record")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "root/Left/go_level/image_levelbg/#txt_level")
	arg_1_0._txtbossName = gohelper.findChildText(arg_1_0.viewGO, "root/Left/#txt_bossName")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/Left/#btn_detail")
	arg_1_0._goheroitem = gohelper.findChild(arg_1_0.viewGO, "root/Right/herogroupcontain/hero/heroitem")
	arg_1_0._goReward = gohelper.findChild(arg_1_0.viewGO, "root/Right/#go_Reward")
	arg_1_0._goRewardRoot = gohelper.findChild(arg_1_0.viewGO, "root/Right/#go_Reward/#go_RewardRoot/#scroll_rewards/Viewport/rewardroot")
	arg_1_0._goRewardItem = gohelper.findChild(arg_1_0.viewGO, "root/Right/#go_Reward/#go_RewardRoot/item")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "root/#go_topleft")
	arg_1_0._simageBoss = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/Left/simage_boss")
	arg_1_0._simageLevel = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/Left/go_level/simage_level")
	arg_1_0._rewardList = {}
	arg_1_0._heroList = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btndetail:RemoveClickListener()
	arg_3_0._click:RemoveClickListener()
end

function var_0_0._onClickClose(arg_4_0)
	arg_4_0:closeThis()

	local var_4_0 = FightModel.instance:getAfterStory()
	local var_4_1 = DungeonConfig.instance:getChapterCO(arg_4_0._curChapterId)
	local var_4_2 = var_4_1 and var_4_1.type == DungeonEnum.ChapterType.RoleStory or var_4_1.id == DungeonEnum.ChapterId.RoleDuDuGu

	if var_4_0 > 0 and (var_4_2 or not StoryModel.instance:isStoryFinished(var_4_0)) then
		var_0_0._storyId = var_4_0
		var_0_0._clientFinish = false
		var_0_0._serverFinish = false

		StoryController.instance:registerCallback(StoryEvent.FinishFromServer, var_0_0._finishStoryFromServer)

		local var_4_3 = {}

		var_4_3.mark = true
		var_4_3.episodeId = DungeonModel.instance.curSendEpisodeId

		StoryController.instance:playStory(var_4_0, var_4_3, function()
			TaskDispatcher.runDelay(var_0_0.onStoryEnd, nil, 3)

			var_0_0._clientFinish = true

			var_0_0.checkStoryEnd()
		end)

		return
	end

	var_0_0.onStoryEnd()
end

function var_0_0._finishStoryFromServer(arg_6_0)
	if var_0_0._storyId == arg_6_0 then
		var_0_0._serverFinish = true

		var_0_0.checkStoryEnd()
	end
end

function var_0_0.checkStoryEnd()
	if var_0_0._clientFinish and var_0_0._serverFinish then
		var_0_0.onStoryEnd()
	end
end

function var_0_0.onStoryEnd()
	var_0_0._storyId = nil
	var_0_0._clientFinish = false
	var_0_0._serverFinish = false

	TaskDispatcher.cancelTask(var_0_0.onStoryEnd, nil)
	StoryController.instance:unregisterCallback(StoryEvent.FinishFromServer, var_0_0._finishStoryFromServer)
	FightController.onResultViewClose()
end

function var_0_0._btndetailOnClick(arg_9_0)
	ViewMgr.instance:openView(ViewName.FightStatView)
end

function var_0_0._editableInitView(arg_10_0)
	return
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._resultMo = OdysseyModel.instance:getFightResultInfo()
	arg_12_0._curChapterId = DungeonModel.instance.curSendChapterId
	arg_12_0._curEpisodeId = FightResultModel.instance.episodeId
	arg_12_0._maxHeroCount = 5

	arg_12_0:_initHeroList()
	arg_12_0:_updateHeroList()
	arg_12_0:_updateRewardList()
	arg_12_0:_updateBoss()
end

function var_0_0._initHeroList(arg_13_0)
	gohelper.setActive(arg_13_0._goheroitem, false)

	for iter_13_0 = 1, arg_13_0._maxHeroCount do
		local var_13_0 = gohelper.findChild(arg_13_0.viewGO, "root/Right/herogroupcontain/hero/bg" .. iter_13_0)
		local var_13_1 = gohelper.findChild(var_13_0, "empty")
		local var_13_2 = gohelper.findChild(var_13_0, "bg")
		local var_13_3 = arg_13_0:getUserDataTb_()

		var_13_3.go = var_13_0
		var_13_3.goempty = var_13_1
		var_13_3.goroot = var_13_2

		table.insert(arg_13_0._heroList, var_13_3)
	end
end

function var_0_0._creatItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if not arg_14_0._rewardList[arg_14_3] then
		local var_14_0 = arg_14_0:getUserDataTb_()
		local var_14_1 = arg_14_1

		var_14_0.itemGO = arg_14_0.viewContainer:getResInst(arg_14_0.viewContainer:getSetting().otherRes[1], var_14_1)
		var_14_0.itemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(var_14_0.itemGO, OdysseyItemIcon)

		if arg_14_2.rewardType == OdysseyEnum.ResultRewardType.Item then
			var_14_0.itemIcon:initItemInfo(arg_14_2.itemType, arg_14_2.itemId, arg_14_2.count)
		elseif arg_14_2.rewardType == OdysseyEnum.ResultRewardType.Exp then
			var_14_0.itemIcon:showTalentItem(arg_14_2.count)
		elseif arg_14_2.rewardType == OdysseyEnum.ResultRewardType.Talent then
			var_14_0.itemIcon:showExpItem(arg_14_2.count)
		elseif arg_14_2.itemType and arg_14_2.itemType == OdysseyEnum.RewardItemType.OuterItem then
			local var_14_2 = {
				type = tonumber(arg_14_2.type),
				id = tonumber(arg_14_2.id)
			}

			var_14_0.itemIcon:initRewardItemInfo(OdysseyEnum.RewardItemType.OuterItem, var_14_2, tonumber(arg_14_2.addCount))
		end

		table.insert(arg_14_0._rewardList, var_14_0)
	end
end

function var_0_0._updateHeroList(arg_15_0)
	local var_15_0, var_15_1 = FightModel.instance:getFightParam():getHeroEquipAndTrialMoList()

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_2 = arg_15_0._heroList[iter_15_0]

		if iter_15_1 and iter_15_1.heroMo then
			local var_15_3 = gohelper.clone(arg_15_0._goheroitem, var_15_2.goroot, "heroItem" .. iter_15_0)
			local var_15_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_3, OdysseyMythResultItem, arg_15_0)

			gohelper.setActive(var_15_2.goempty, false)
			gohelper.setActive(var_15_3, true)
			var_15_4:setResFunc(arg_15_0.getEquipPrefab, arg_15_0)
			var_15_4:setData(iter_15_1.heroMo, iter_15_1.equipMo, iter_15_0)
		else
			gohelper.setActive(var_15_2.goempty, true)
		end
	end
end

function var_0_0.getEquipPrefab(arg_16_0, arg_16_1)
	return arg_16_0:getResInst(arg_16_0.viewContainer:getSetting().otherRes[2], arg_16_1)
end

function var_0_0._updateRewardList(arg_17_0)
	local var_17_0 = arg_17_0._resultMo:getRewardList()
	local var_17_1 = OdysseyItemModel.instance:getAddOuterItemList()
	local var_17_2 = {}

	tabletool.addValues(var_17_2, var_17_1)
	tabletool.addValues(var_17_2, var_17_0)

	if var_17_2 and #var_17_2 > 0 then
		gohelper.setActive(arg_17_0._goReward, true)
		gohelper.CreateObjList(arg_17_0, arg_17_0._creatItem, var_17_2, arg_17_0._goRewardRoot, arg_17_0._goRewardItem)
	else
		gohelper.setActive(arg_17_0._goReward, false)
	end
end

function var_0_0._updateBoss(arg_18_0)
	local var_18_0 = OdysseyConfig.instance:getMythConfigByElementId(arg_18_0._resultMo:getElementId())

	arg_18_0._simageBoss:LoadImage(ResUrl.getSp01OdysseySingleBg(var_18_0.res))

	arg_18_0._txtbossName.text = var_18_0.name

	local var_18_1 = #arg_18_0._resultMo:getFightFinishedTaskIdList()
	local var_18_2 = "pingji_x_" .. var_18_1
	local var_18_3 = "mythcreatures/odyssey_mythcreatures_level_" .. var_18_1

	arg_18_0._simageLevel:LoadImage(ResUrl.getSp01OdysseySingleBg(var_18_3))
	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_18_0._imagerecord, var_18_2)

	arg_18_0._txtlevel.text = luaLang("odyssey_dungeon_mapselectinfo_mythRecord" .. var_18_1)
end

function var_0_0.onClose(arg_19_0)
	return
end

function var_0_0.onDestroyView(arg_20_0)
	OdysseyModel.instance:clearResultInfo()
end

return var_0_0
