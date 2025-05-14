module("modules.logic.dungeon.view.DungeonCumulativeRewardPackView", package.seeall)

local var_0_0 = class("DungeonCumulativeRewardPackView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._txtprogress = gohelper.findChildText(arg_1_0.viewGO, "#txt_progress")
	arg_1_0._imagepoint = gohelper.findChildImage(arg_1_0.viewGO, "go_progress/#image_point")
	arg_1_0._imagenormalright = gohelper.findChildImage(arg_1_0.viewGO, "go_progress/#image_normal_right")
	arg_1_0._imagenormalleft = gohelper.findChildImage(arg_1_0.viewGO, "go_progress/#image_normal_left")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "#go_rewards")
	arg_1_0._gorewardtemplate = gohelper.findChild(arg_1_0.viewGO, "#go_rewards/#go_reward_template")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_tips")
	arg_1_0._txttipsinfo = gohelper.findChildText(arg_1_0.viewGO, "#go_tips/#txt_tipsinfo")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_leftbg")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_rightbg")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getDungeonIcon("full/guankajianlibiejing_038"))
	arg_5_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_5_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	arg_5_0._txttitlecn = gohelper.findChildText(arg_5_0.viewGO, "titlecn")
	arg_5_0._txttitleen = gohelper.findChildText(arg_5_0.viewGO, "titlecn/titleen")
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0._getPointRewardRequest(arg_7_0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.DelayGetPointReward) then
		return
	end

	local var_7_0 = DungeonMapModel.instance:canGetRewards(arg_7_0._chapterId)

	if var_7_0 and #var_7_0 > 0 then
		DungeonRpc.instance:sendGetPointRewardRequest(var_7_0)
	end
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._chapterId = arg_8_0.viewParam.chapterId

	if not GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.DelayGetPointReward) then
		TaskDispatcher.runDelay(arg_8_0._getPointRewardRequest, arg_8_0, 0.6)
	end

	NavigateMgr.instance:addEscape(arg_8_0.viewName, arg_8_0._btncloseOnClick, arg_8_0)

	arg_8_0._pointRewardCfg = DungeonConfig.instance:getChapterPointReward(arg_8_0._chapterId)
	arg_8_0._pointRewardInfo = DungeonMapModel.instance:getRewardPointInfo(arg_8_0._chapterId)

	local var_8_0 = #arg_8_0._pointRewardCfg

	if var_8_0 > 0 then
		arg_8_0._lastPointRewardCfg = arg_8_0._pointRewardCfg[var_8_0]
	end

	local var_8_1 = DungeonConfig.instance:getChapterCO(arg_8_0._chapterId)

	arg_8_0._txttitlecn.text = var_8_1.name
	arg_8_0._txttitleen.text = var_8_1.name_En

	arg_8_0:createRewardUIs()
	arg_8_0:refreshRewardItems()
	arg_8_0:refreshUnlockCondition()
	arg_8_0:refreshProgress()
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.OnGetPointReward, arg_8_0.refreshRewardItems, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.GuideGetPointReward, arg_8_0._getPointRewardRequest, arg_8_0)
end

function var_0_0.createRewardUIs(arg_9_0)
	local var_9_0 = arg_9_0._pointRewardCfg
	local var_9_1 = arg_9_0._pointRewardInfo
	local var_9_2 = arg_9_0._lastPointRewardCfg

	if arg_9_0._isInitItems or not var_9_2 then
		return
	end

	local var_9_3 = string.split(var_9_2.reward, "|")

	arg_9_0._isInitItems = true
	arg_9_0._rewarditems = {}

	for iter_9_0 = 1, #var_9_3 do
		local var_9_4 = string.splitToNumber(var_9_3[iter_9_0], "#")
		local var_9_5 = arg_9_0:getUserDataTb_()
		local var_9_6 = gohelper.clone(arg_9_0._gorewardtemplate, arg_9_0._gorewards, "reward_" .. tostring(iter_9_0))

		var_9_5.imagebg = gohelper.findChildImage(var_9_6, "image_bg")
		var_9_5.simagereward = gohelper.findChildSingleImage(var_9_6, "simage_reward")
		var_9_5.txtrewardcount = gohelper.findChildText(var_9_6, "txt_rewardcount")
		var_9_5.imagereward = var_9_5.simagereward:GetComponent(gohelper.Type_Image)
		var_9_5.btn = gohelper.findChildClick(var_9_6, "simage_reward")
		var_9_5.goalreadygot = gohelper.findChild(var_9_6, "go_hasget")

		var_9_5.btn:AddClickListener(arg_9_0.onClickItem, arg_9_0, var_9_5)

		var_9_5.go = var_9_6
		var_9_5.rewardCfg = var_9_4
		var_9_5.itemCfg, var_9_5.iconPath = ItemModel.instance:getItemConfigAndIcon(var_9_4[1], var_9_4[2])

		gohelper.setActive(var_9_5.go, true)
		table.insert(arg_9_0._rewarditems, var_9_5)
	end
end

function var_0_0.refreshRewardItems(arg_10_0)
	local var_10_0 = arg_10_0._pointRewardInfo
	local var_10_1 = arg_10_0._lastPointRewardCfg

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._rewarditems) do
		arg_10_0:refreshRewardUIItem(iter_10_1, var_10_1, var_10_0)
	end
end

local var_0_1 = Color.New(0.6941177, 0.6941177, 0.6941177, 1)
local var_0_2 = Color.New(1, 1, 1, 1)
local var_0_3 = Color.New(1, 1, 1, 0.5)
local var_0_4 = Color.New(1, 1, 1, 1)
local var_0_5 = Color.New(0.227451, 0.227451, 0.227451, 1)
local var_0_6 = Color.New(0.227451, 0.227451, 0.227451, 1)

function var_0_0.refreshRewardUIItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = tabletool.indexOf(arg_11_3.hasGetPointRewardIds, arg_11_2.id)
	local var_11_1 = var_11_0 and var_0_1 or var_0_2
	local var_11_2 = var_11_0 and var_0_3 or var_0_4
	local var_11_3 = var_11_0 and var_0_5 or var_0_6

	arg_11_1.imagereward.color = var_11_1
	arg_11_1.imagebg.color = var_11_2
	arg_11_1.txtrewardcount.color = var_11_3

	arg_11_1.simagereward:LoadImage(arg_11_1.iconPath)

	arg_11_1.txtrewardcount.text = tostring(arg_11_1.rewardCfg[3])

	gohelper.setActive(arg_11_1.goalreadygot, var_11_0)
end

function var_0_0.onClickItem(arg_12_0, arg_12_1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	MaterialTipController.instance:showMaterialInfo(arg_12_1.rewardCfg[1], arg_12_1.rewardCfg[2])
end

function var_0_0.refreshUnlockCondition(arg_13_0)
	local var_13_0 = DungeonConfig.instance:getUnlockChapterConfig(arg_13_0._chapterId)

	if not var_13_0 then
		gohelper.setActive(arg_13_0._gotips, false)

		return
	end

	gohelper.setActive(arg_13_0._gotips, true)

	local var_13_1, var_13_2 = DungeonMapModel.instance:getTotalRewardPointProgress(arg_13_0._chapterId)
	local var_13_3 = {
		tostring(var_13_2),
		var_13_0.name
	}

	arg_13_0._txttipsinfo.text = GameUtil.getSubPlaceholderLuaLang(luaLang("dungeoncumulativerewardsview_tips"), var_13_3)
end

function var_0_0.refreshProgress(arg_14_0)
	local var_14_0, var_14_1 = DungeonMapModel.instance:getTotalRewardPointProgress(arg_14_0._chapterId)

	arg_14_0._txtprogress.text = string.format("%s/%s", var_14_0, var_14_1)

	local var_14_2 = arg_14_0._lastPointRewardCfg.rewardPointNum
	local var_14_3 = var_14_0 / var_14_1

	arg_14_0._imagenormalleft.fillAmount = var_14_3
	arg_14_0._imagenormalright.fillAmount = var_14_3

	local var_14_4 = var_14_2 <= arg_14_0._pointRewardInfo.rewardPoint

	UISpriteSetMgr.instance:setUiFBSprite(arg_14_0._imagepoint, var_14_4 and "xingjidian_dian2_005" or "xingjidian_dian1_004")
end

function var_0_0.onClose(arg_15_0)
	if arg_15_0._isInitItems then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._rewarditems) do
			iter_15_1.btn:RemoveClickListener()
			iter_15_1.simagereward:UnLoadImage()
		end
	end

	TaskDispatcher.cancelTask(arg_15_0._getPointRewardRequest, arg_15_0)
end

function var_0_0.onDestroyView(arg_16_0)
	arg_16_0._simagebg:UnLoadImage()
	arg_16_0._simageleftbg:UnLoadImage()
	arg_16_0._simagerightbg:UnLoadImage()
end

return var_0_0
