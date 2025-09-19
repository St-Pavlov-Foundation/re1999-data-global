module("modules.logic.activity.view.V2a8_DragonBoat_RewardItem", package.seeall)

local var_0_0 = class("V2a8_DragonBoat_RewardItem", Activity101SignViewItemBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageitembg = gohelper.findChildSingleImage(arg_1_0.viewGO, "Root/#simage_itembg")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "Root/#txt_title")
	arg_1_0._scrollItemList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Root/unlock/#scroll_ItemList")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "Root/lock/#txt_LimitTime")
	arg_1_0._goreward1 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_reward1")
	arg_1_0._goreward2 = gohelper.findChild(arg_1_0.viewGO, "Root/#go_reward2")
	arg_1_0._goepisode = gohelper.findChild(arg_1_0.viewGO, "#go_episode")
	arg_1_0._txtepisode = gohelper.findChildText(arg_1_0.viewGO, "#go_episode/#txt_episode")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

local var_0_1 = string.splitToNumber
local var_0_2 = string.split
local var_0_3 = SLFramework.AnimatorPlayer

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._unlockGo = gohelper.findChild(arg_4_0.viewGO, "Root/unlock")
	arg_4_0._lockGo = gohelper.findChild(arg_4_0.viewGO, "Root/lock")
	arg_4_0._txt_unlockTips = gohelper.findChildText(arg_4_0.viewGO, "Root/lock/txt_unlockTips")
	arg_4_0._txt_unlockTipsGo = arg_4_0._txt_unlockTips.gameObject
	arg_4_0._txtLimitTimeGo = arg_4_0._txtLimitTime.gameObject
	arg_4_0._unlock_scrollItemListGo = gohelper.findChild(arg_4_0.viewGO, "Root/unlock/#scroll_ItemList")
	arg_4_0._contentGo = gohelper.findChild(arg_4_0._unlock_scrollItemListGo, "Viewport/Content")
	arg_4_0._txtdec = gohelper.findChildText(arg_4_0.viewGO, "Root/unlock/#scroll_ItemList/Viewport/Content")
	arg_4_0._animPlayer = var_0_3.Get(arg_4_0.viewGO)
	arg_4_0._anim = arg_4_0._animPlayer.animator
	arg_4_0._itemList = {}

	for iter_4_0 = 1, 5 do
		local var_4_0 = arg_4_0["_goreward" .. iter_4_0]

		if not var_4_0 then
			break
		end

		arg_4_0._itemList[iter_4_0] = arg_4_0:_create_V2a8_DragonBoat_RewardItemItem(iter_4_0, var_4_0)
	end

	arg_4_0:_setActive_lockGo(false)
	arg_4_0:_setActive_unlockGo(false)
end

function var_0_0.onRefresh(arg_5_0)
	if not arg_5_0.__isSetScrollparentGameObject then
		arg_5_0:setScrollparentGameObject(arg_5_0._unlock_scrollItemListGo)

		arg_5_0.__isSetScrollparentGameObject = true
	end

	local var_5_0 = arg_5_0:actId()
	local var_5_1 = arg_5_0._index
	local var_5_2 = arg_5_0:_getDayCO()
	local var_5_3 = arg_5_0:_isHasGet()
	local var_5_4 = arg_5_0:_isCanGet()
	local var_5_5 = ActivityType101Model.instance:getType101LoginCount(var_5_0)
	local var_5_6 = var_5_3 or var_5_4
	local var_5_7 = var_5_5 < var_5_1

	arg_5_0:_onRefresh_rewardList(var_5_3, var_5_4)

	arg_5_0._txttitle.text = var_5_2 and var_5_2.titile or ""
	arg_5_0._txtdec.text = var_5_2 and var_5_2.desc or ""
	arg_5_0._txtLimitTime.text = formatLuaLang("V2a8_DragonBoat_RewardItem_txt_unlockTips", var_5_1 - var_5_5)

	gohelper.setActive(arg_5_0._txt_unlockTipsGo, not var_5_7)
	gohelper.setActive(arg_5_0._txtLimitTimeGo, var_5_7)
	arg_5_0:_setActive_lockGo(not var_5_6)
	arg_5_0:_setActive_unlockGo(var_5_6)
end

function var_0_0.actId(arg_6_0)
	return arg_6_0._mo.data[1]
end

function var_0_0._onRefresh_rewardList(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:actId()
	local var_7_1 = arg_7_0._index
	local var_7_2 = ActivityConfig.instance:getNorSignActivityCo(var_7_0, var_7_1)
	local var_7_3 = var_0_2(var_7_2.bonus, "|") or {}

	for iter_7_0, iter_7_1 in ipairs(var_7_3) do
		local var_7_4 = var_0_1(iter_7_1, "#")
		local var_7_5 = arg_7_0._itemList[iter_7_0]

		if not var_7_5 then
			var_7_5 = arg_7_0:_create_V2a8_DragonBoat_RewardItemItem(iter_7_0)

			table.insert(arg_7_0._itemList, var_7_5)
		end

		var_7_5:setActive(true)
		var_7_5:onUpdateMO(var_7_4)
		var_7_5:setActive_hasgetGo(arg_7_1)
		var_7_5:setActive_cangetGo(arg_7_2)
	end

	for iter_7_2 = #var_7_3 + 1, #arg_7_0._itemList do
		arg_7_0._itemList[iter_7_2]:setActive(false)
	end
end

function var_0_0._isCanGet(arg_8_0)
	local var_8_0 = arg_8_0:actId()
	local var_8_1 = arg_8_0._index

	if not ActivityType101Model.instance:isType101RewardCouldGet(var_8_0, var_8_1) then
		return false
	end

	return arg_8_0:viewContainer():isStateDone(var_8_1)
end

function var_0_0._getDayCO(arg_9_0)
	return arg_9_0:viewContainer():getDayCO(arg_9_0._index)
end

function var_0_0._isHasGet(arg_10_0)
	local var_10_0 = arg_10_0:actId()
	local var_10_1 = arg_10_0._index

	return ActivityType101Model.instance:isType101RewardGet(var_10_0, var_10_1)
end

function var_0_0.onItemClick(arg_11_0)
	local var_11_0 = arg_11_0:actId()
	local var_11_1 = arg_11_0._index

	AudioMgr.instance:trigger(AudioEnum.UI.Store_Good_Click)

	if not ActivityModel.instance:isActOnLine(var_11_0) then
		GameFacade.showToast(ToastEnum.BattlePass)

		return true
	end

	if arg_11_0:_isCanGet() then
		arg_11_0:viewContainer():setOnceGotRewardFetch101Infos(true)
		Activity101Rpc.instance:sendGet101BonusRequest(var_11_0, var_11_1)

		return true
	end

	return false
end

function var_0_0._create_V2a8_DragonBoat_RewardItemItem(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2 = arg_12_2 or gohelper.cloneInPlace(arg_12_0._goreward1)

	local var_12_0 = V2a8_DragonBoat_RewardItemItem.New({
		parent = arg_12_0,
		baseViewContainer = arg_12_0.viewContainer
	})

	var_12_0:setIndex(arg_12_1)
	var_12_0:init(arg_12_2)

	return var_12_0
end

function var_0_0._setActive_lockGo(arg_13_0, arg_13_1)
	gohelper.setActive(arg_13_0._lockGo, arg_13_1)
end

function var_0_0._setActive_unlockGo(arg_14_0, arg_14_1)
	gohelper.setActive(arg_14_0._unlockGo, arg_14_1)
end

function var_0_0._playAnim(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0._anim.enabled = true

	arg_15_0._animPlayer:Play(arg_15_1, arg_15_2 or function()
		return
	end, arg_15_3)
end

function var_0_0.playAnim_unlock(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0:_setActive_unlockGo(true)
	arg_17_0:_setActive_lockGo(false)
	arg_17_0:_playAnim(UIAnimationName.Unlock, function()
		if arg_17_1 then
			arg_17_1(arg_17_2)
		end

		arg_17_0:_onRefresh_rewardList(false, true)
	end)
end

return var_0_0
