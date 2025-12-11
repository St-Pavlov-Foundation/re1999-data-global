module("modules.logic.roomfishing.view.RoomFishingFriendItem", package.seeall)

local var_0_0 = class("RoomFishingFriendItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goheadicon = gohelper.findChild(arg_1_0.viewGO, "#go_headicon")
	arg_1_0._txtPlayerName = gohelper.findChildText(arg_1_0.viewGO, "#txt_PlayerName")
	arg_1_0._govisit = gohelper.findChild(arg_1_0.viewGO, "txt_State")
	arg_1_0._goUnFinished = gohelper.findChild(arg_1_0.viewGO, "Schedule/#go_UnFinished")
	arg_1_0._imagefishing = gohelper.findChildImage(arg_1_0.viewGO, "Schedule/#go_UnFinished/image_ScheduleFG")
	arg_1_0._imageItemBG = gohelper.findChildImage(arg_1_0.viewGO, "Schedule/#image_ItemBG")
	arg_1_0._simageProp = gohelper.findChildSingleImage(arg_1_0.viewGO, "Schedule/#simage_Prop")
	arg_1_0._txtSchedule = gohelper.findChildText(arg_1_0.viewGO, "Schedule/#txt_Schedule")
	arg_1_0._btnclick = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	if not arg_4_0._mo then
		return
	end

	FishingController.instance:visitOtherFishingPool(arg_4_0._mo.userId)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._playericon = IconMgr.instance:getCommonPlayerIcon(arg_5_0._goheadicon)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1

	arg_6_0:refreshInfo()
	arg_6_0:refreshStatus()
end

function var_0_0.refreshInfo(arg_7_0)
	if not arg_7_0._mo then
		return
	end

	local var_7_0 = arg_7_0._mo.userId
	local var_7_1 = CommonConfig.instance:getConstNum(ConstEnum.PlayerDefaultIcon)

	arg_7_0._playericon:setMOValue(var_7_0, "", 0, arg_7_0._mo.portrait or var_7_1)
	arg_7_0._playericon:setShowLevel(false)
	arg_7_0._playericon:setEnableClick(false)

	arg_7_0._txtPlayerName.text = arg_7_0._mo.name

	local var_7_2 = FishingModel.instance:getCurShowingUserId()

	gohelper.setActive(arg_7_0._govisit, var_7_0 == var_7_2)

	local var_7_3 = FishingConfig.instance:getFishingPoolItem(arg_7_0._mo.poolId)

	if var_7_3 then
		local var_7_4, var_7_5 = ItemModel.instance:getItemConfigAndIcon(var_7_3[1], var_7_3[2])

		UISpriteSetMgr.instance:setRoomSprite(arg_7_0._imageItemBG, "roomfish_itemqualitybg2_" .. CharacterEnum.Color[var_7_4.rare], true)
		arg_7_0._simageProp:LoadImage(var_7_5)
	end
end

function var_0_0.refreshStatus(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.timerUpdate, arg_8_0)

	local var_8_0 = arg_8_0._mo and arg_8_0._mo.userId
	local var_8_1 = FishingModel.instance:getIsFishingInUserPool(var_8_0)

	if var_8_1 then
		arg_8_0:timerUpdate()
		TaskDispatcher.runRepeat(arg_8_0.timerUpdate, arg_8_0, TimeUtil.OneSecond)
	else
		arg_8_0._txtSchedule.text = luaLang("p_roomview_fishing_reward")
	end

	gohelper.setActive(arg_8_0._goUnFinished, var_8_1)
end

function var_0_0.timerUpdate(arg_9_0)
	local var_9_0 = arg_9_0._mo and arg_9_0._mo.userId

	if FishingModel.instance:getIsFishingInUserPool(var_9_0) and arg_9_0._txtSchedule and arg_9_0._imagefishing then
		local var_9_1 = FishingModel.instance:getMyFishingProgress(var_9_0)
		local var_9_2 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("percent"), var_9_1)

		arg_9_0._imagefishing.fillAmount = Mathf.Clamp01(var_9_1 / 100)
		arg_9_0._txtSchedule.text = var_9_2
	else
		TaskDispatcher.cancelTask(arg_9_0.timerUpdate, arg_9_0)
	end
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simageProp:UnLoadImage()
	TaskDispatcher.cancelTask(arg_10_0.timerUpdate, arg_10_0)
end

return var_0_0
