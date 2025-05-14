module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotProgressItem", package.seeall)

local var_0_0 = class("V1a6_CachotProgressItem", MixScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._gounlock = gohelper.findChild(arg_1_1, "#go_unlock")
	arg_1_0._golock = gohelper.findChild(arg_1_1, "#go_lock")
	arg_1_0._txtscore = gohelper.findChildText(arg_1_1, "#go_unlock/scorebg/#txt_score")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_1, "#go_unlock/#go_item/#go_rewarditem")
	arg_1_0._imagepoint = gohelper.findChildImage(arg_1_1, "#go_unlock/#image_point")
	arg_1_0._txtlocktip = gohelper.findChildText(arg_1_1, "#go_lock/#txt_locktip")
	arg_1_0._txtindex = gohelper.findChildText(arg_1_1, "#go_unlock/#txt_index")
	arg_1_0._gospecial = gohelper.findChild(arg_1_1, "#go_unlock/#go_special")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onDestroy(arg_5_0)
	arg_5_0:releaseRewardIconTab()
	TaskDispatcher.cancelTask(arg_5_0.refreshUnLockNextStageTimeUI, arg_5_0)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0._mo = arg_6_1

	arg_6_0:refreshUI()
end

function var_0_0.refreshUI(arg_7_0)
	gohelper.setActive(arg_7_0._golock, arg_7_0._mo.isLocked)
	gohelper.setActive(arg_7_0._gounlock, not arg_7_0._mo.isLocked)
	TaskDispatcher.cancelTask(arg_7_0.refreshUnLockNextStageTimeUI, arg_7_0)

	if arg_7_0._mo.isLocked then
		arg_7_0:onItemLocked()

		return
	end

	local var_7_0 = V1a6_CachotScoreConfig.instance:getStagePartConfig(arg_7_0._mo.id)

	if var_7_0 then
		local var_7_1 = V1a6_CachotProgressListModel.instance:getRewardState(arg_7_0._mo.id)

		arg_7_0:refreshNormalUI(var_7_0)
		arg_7_0:refreshStateUI(var_7_0, var_7_1)
		arg_7_0:refreshRewardItems(var_7_0.reward, var_7_1)
	end
end

function var_0_0.refreshNormalUI(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1 and arg_8_1.special == 1

	gohelper.setActive(arg_8_0._gospecial, var_8_0)
end

function var_0_0.onItemLocked(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.refreshUnLockNextStageTimeUI, arg_9_0)
	TaskDispatcher.runRepeat(arg_9_0.refreshUnLockNextStageTimeUI, arg_9_0, TimeUtil.OneMinuteSecond)
	arg_9_0:refreshUnLockNextStageTimeUI()
end

function var_0_0.refreshUnLockNextStageTimeUI(arg_10_0)
	local var_10_0 = V1a6_CachotProgressListModel.instance:getUnLockNextStageRemainTime()

	if var_10_0 and var_10_0 > 0 then
		local var_10_1, var_10_2 = TimeUtil.secondsToDDHHMMSS(var_10_0)

		if var_10_1 > 0 then
			arg_10_0._txtlocktip.text = formatLuaLang("v1a6_cachotprogressview_unlocktips_days", var_10_1)
		else
			arg_10_0._txtlocktip.text = formatLuaLang("v1a6_cachotprogressview_unlocktips_hours", var_10_2)
		end
	else
		TaskDispatcher.cancelTask(arg_10_0.refreshUnLockNextStageTimeUI, arg_10_0)
	end
end

local var_0_1 = "#DB7D29"
local var_0_2 = "#FFFFFF"
local var_0_3 = 0.3
local var_0_4 = 0.3
local var_0_5 = "#DB7D29"
local var_0_6 = "#8E8E8E"

function var_0_0.refreshStateUI(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = "v1a6_cachot_icon_pointdark"
	local var_11_1 = var_0_2
	local var_11_2 = var_0_3
	local var_11_3 = var_0_6
	local var_11_4 = arg_11_1 and arg_11_1.special == 1

	if arg_11_2 == V1a6_CachotEnum.MilestonesState.UnFinish then
		var_11_0 = var_11_4 and "v1a6_cachot_icon_pointdark2" or "v1a6_cachot_icon_pointdark"
	else
		var_11_0 = var_11_4 and "v1a6_cachot_icon_pointlight2" or "v1a6_cachot_icon_pointlight"
		var_11_1 = var_0_1
		var_11_2 = var_0_4
		var_11_3 = var_0_5
	end

	UISpriteSetMgr.instance:setV1a6CachotSprite(arg_11_0._imagepoint, var_11_0)

	arg_11_0._txtscore.text = string.format("<%s>%s</color>", var_11_3, arg_11_1.score)
	arg_11_0._txtindex.text = arg_11_0._index

	SLFramework.UGUI.GuiHelper.SetColor(arg_11_0._txtindex, var_11_1)
	ZProj.UGUIHelper.SetColorAlpha(arg_11_0._txtindex, var_11_2)
end

local var_0_7 = 0.5
local var_0_8 = 1
local var_0_9 = 0.5
local var_0_10 = 1
local var_0_11 = 0.5
local var_0_12 = 1

function var_0_0.refreshRewardItems(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = {}

	local function var_12_1(arg_13_0)
		local var_13_0 = arg_13_0.simageicon.gameObject:GetComponent(typeof(UnityEngine.UI.Image))

		var_13_0:SetNativeSize()
		ZProj.UGUIHelper.SetColorAlpha(var_13_0, arg_12_2 == V1a6_CachotEnum.MilestonesState.HasReceived and var_0_9 or var_0_10)
	end

	if arg_12_1 then
		local var_12_2 = string.split(arg_12_1, "|")

		for iter_12_0 = 1, #var_12_2 do
			local var_12_3 = string.splitToNumber(var_12_2[iter_12_0], "#")
			local var_12_4 = arg_12_0:getOrCreateRewardItem(iter_12_0)

			arg_12_0:refreshSingleRewardItem(var_12_4, var_12_3, arg_12_2, var_12_1)

			var_12_0[var_12_4] = true
		end
	end

	arg_12_0:recycleUnUseRewardItem(var_12_0)
end

function var_0_0.getOrCreateRewardItem(arg_14_0, arg_14_1)
	arg_14_0._rewardItemTab = arg_14_0._rewardItemTab or {}

	local var_14_0 = arg_14_0._rewardItemTab[arg_14_1]

	if not var_14_0 then
		var_14_0 = arg_14_0:getUserDataTb_()
		var_14_0.go = gohelper.cloneInPlace(arg_14_0._gorewarditem, "reward_" .. arg_14_1)
		var_14_0.imagebg = gohelper.findChildImage(var_14_0.go, "bg")
		var_14_0.simageicon = gohelper.findChildSingleImage(var_14_0.go, "simage_reward")
		var_14_0.goheadframe = gohelper.findChild(var_14_0.go, "go_headframe")
		var_14_0.frameCanvasGroup = gohelper.onceAddComponent(var_14_0.goheadframe, typeof(UnityEngine.CanvasGroup))
		var_14_0.gocanget = gohelper.findChild(var_14_0.go, "go_canget")
		var_14_0.gohasget = gohelper.findChild(var_14_0.go, "go_hasget")
		var_14_0.txtrewardcount = gohelper.findChildText(var_14_0.go, "txt_rewardcount")
		var_14_0.btnclick = gohelper.findChildButtonWithAudio(var_14_0.go, "btn_click")
		arg_14_0._rewardItemTab[arg_14_1] = var_14_0
	end

	return var_14_0
end

function var_0_0.refreshSingleRewardItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = arg_15_2 and arg_15_2[1]
	local var_15_1 = arg_15_2 and arg_15_2[2]
	local var_15_2 = arg_15_2 and arg_15_2[3]
	local var_15_3, var_15_4 = ItemModel.instance:getItemConfigAndIcon(var_15_0, var_15_1)

	UISpriteSetMgr.instance:setV1a6CachotSprite(arg_15_1.imagebg, "v1a6_cachot_img_quality_" .. var_15_3.rare)
	ZProj.UGUIHelper.SetColorAlpha(arg_15_1.imagebg, arg_15_3 == V1a6_CachotEnum.MilestonesState.HasReceived and var_0_7 or var_0_8)
	gohelper.setActive(arg_15_1.goheadframe, false)
	gohelper.setActive(arg_15_1.txtrewardcount, true)

	if var_15_0 == MaterialEnum.MaterialType.Equip then
		arg_15_1.simageicon:LoadImage(ResUrl.getHeroDefaultEquipIcon(var_15_3.icon), arg_15_4, arg_15_1)
	elseif var_15_3.subType == ItemEnum.SubType.Portrait then
		local var_15_5 = arg_15_3 == V1a6_CachotEnum.MilestonesState.HasReceived and var_0_11 or var_0_12

		if not arg_15_0._liveHeadIcon then
			arg_15_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_15_1.simageicon)
		end

		arg_15_0._liveHeadIcon:setLiveHead(tonumber(var_15_3.icon), true, nil, function(arg_16_0, arg_16_1)
			arg_16_1:setAlpha(var_15_5)
		end, arg_15_0)
		gohelper.setActive(arg_15_1.goheadframe, true)
		gohelper.setActive(arg_15_1.txtrewardcount, false)

		arg_15_1.frameCanvasGroup.alpha = var_15_5
	else
		arg_15_1.simageicon:LoadImage(var_15_4, arg_15_4, arg_15_1)
	end

	arg_15_1.txtrewardcount.text = formatLuaLang("cachotprogressview_rewardcount", var_15_2)

	gohelper.setActive(arg_15_1.gohasget, arg_15_3 == V1a6_CachotEnum.MilestonesState.HasReceived)
	gohelper.setActive(arg_15_1.gocanget, arg_15_3 == V1a6_CachotEnum.MilestonesState.CanReceive)
	gohelper.setActive(arg_15_1.go, true)
	arg_15_1.btnclick:RemoveClickListener()
	arg_15_1.btnclick:AddClickListener(arg_15_0.onClickRewardItem, arg_15_0, arg_15_2)
end

function var_0_0.onClickRewardItem(arg_17_0, arg_17_1)
	if V1a6_CachotProgressListModel.instance:getRewardState(arg_17_0._mo.id) == V1a6_CachotEnum.MilestonesState.CanReceive then
		local var_17_0 = V1a6_CachotProgressListModel.instance:getCanReceivePartIdList()

		RogueRpc.instance:sendGetRogueScoreRewardRequest(V1a6_CachotEnum.ActivityId, var_17_0)
	elseif arg_17_1 then
		MaterialTipController.instance:showMaterialInfo(arg_17_1[1], arg_17_1[2])
	end
end

function var_0_0.recycleUnUseRewardItem(arg_18_0, arg_18_1)
	if arg_18_1 and arg_18_0._rewardItemTab then
		for iter_18_0, iter_18_1 in pairs(arg_18_0._rewardItemTab) do
			if not arg_18_1[iter_18_1] then
				gohelper.setActive(iter_18_1.go, false)
			end
		end
	end
end

function var_0_0.releaseRewardIconTab(arg_19_0)
	if arg_19_0._rewardItemTab then
		for iter_19_0, iter_19_1 in pairs(arg_19_0._rewardItemTab) do
			if iter_19_1.btnclick then
				iter_19_1.btnclick:RemoveClickListener()
			end

			if iter_19_1.simageicon then
				iter_19_1.simageicon:UnLoadImage()
			end
		end
	end
end

return var_0_0
