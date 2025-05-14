module("modules.logic.versionactivity2_4.act181.view.Activity181BonusItem", package.seeall)

local var_0_0 = class("Activity181BonusItem", LuaCompBase)

var_0_0.ANI_IDLE = "idle"
var_0_0.ANI_CAN_GET = "get"
var_0_0.ANI_COVER_OPEN = "coveropen"

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._imgQuality = gohelper.findChildImage(arg_1_1, "OptionalItem/#img_Quality")
	arg_1_0._simgItem = gohelper.findChildSingleImage(arg_1_1, "OptionalItem/#simage_Item")
	arg_1_0._goOptionalItem = gohelper.findChild(arg_1_1, "OptionalItem")
	arg_1_0._goImageBg = gohelper.findChild(arg_1_1, "image_BG")
	arg_1_0._txtNum = gohelper.findChildTextMesh(arg_1_1, "OptionalItem/image_NumBG/#txt_Num")
	arg_1_0._txtItemName = gohelper.findChildTextMesh(arg_1_1, "OptionalItem/#txt_ItemName")
	arg_1_0._goCover = gohelper.findChild(arg_1_1, "#go_Cover")
	arg_1_0._goGet = gohelper.findChild(arg_1_1, "#go_Get")
	arg_1_0._goCoverClose = gohelper.findChild(arg_1_1, "image_Cover")
	arg_1_0._goCoverOpen = gohelper.findChild(arg_1_1, "image_CoverOpen")
	arg_1_0._btnClick = gohelper.findChildButton(arg_1_1, "click")
	arg_1_0._goType1 = gohelper.findChild(arg_1_1, "#go_Cover/#go_Type1")
	arg_1_0._goType2 = gohelper.findChild(arg_1_1, "#go_Cover/#go_Type2")
	arg_1_0._goType3 = gohelper.findChild(arg_1_1, "#go_Cover/#go_Type3")
	arg_1_0._goType4 = gohelper.findChild(arg_1_1, "#go_Cover/#go_Type4")

	arg_1_0:initItem()
end

function var_0_0.initItem(arg_2_0)
	arg_2_0._typeList = {
		arg_2_0._goType1,
		arg_2_0._goType2,
		arg_2_0._goType3,
		arg_2_0._goType4
	}

	arg_2_0._btnClick:AddClickListener(arg_2_0.onClickItem, arg_2_0)

	arg_2_0._animator = gohelper.findChildComponent(arg_2_0.go, "", gohelper.Type_Animator)

	gohelper.setActive(arg_2_0._txtItemName, false)

	arg_2_0._animator.enabled = true
end

function var_0_0.onClickItem(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20190324)

	if not Activity181Model.instance:isActivityInTime(arg_3_0._activityId) then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	local var_3_0 = Activity181Model.instance:getActivityInfo(arg_3_0._activityId)

	if var_3_0:getBonusState(arg_3_0._pos) == Activity181Enum.BonusState.HaveGet then
		local var_3_1 = Activity181Config.instance:getBoxListConfig(arg_3_0._activityId, arg_3_0._boxId)
		local var_3_2 = string.splitToNumber(var_3_1.bonus, "#")

		MaterialTipController.instance:showMaterialInfo(var_3_2[1], var_3_2[2], false)

		return
	end

	if var_3_0.canGetTimes <= 0 then
		GameFacade.showToast(ToastEnum.NorSign)

		return
	end

	if Activity181Model.instance:getPopUpPauseState() then
		return
	end

	Activity181Controller.instance:getBonus(arg_3_0._activityId, arg_3_0._pos)
end

function var_0_0.setEnable(arg_4_0, arg_4_1)
	gohelper.setActive(arg_4_0.go, arg_4_1)
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._pos = arg_5_1
	arg_5_0._activityId = arg_5_2

	local var_5_0 = Activity181Model.instance:getActivityInfo(arg_5_2)
	local var_5_1 = var_5_0:getBonusState(arg_5_1) == Activity181Enum.BonusState.HaveGet
	local var_5_2 = var_5_0:getBonusTimes() > 0
	local var_5_3
	local var_5_4

	if arg_5_3 then
		var_5_3 = true
		var_5_4 = arg_5_0.ANI_COVER_OPEN

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_clue_get)
	else
		var_5_3 = var_5_1
		var_5_4 = var_5_2 and not var_5_1 and arg_5_0.ANI_CAN_GET or arg_5_0.ANI_IDLE
	end

	gohelper.setActive(arg_5_0._goImageBg, var_5_3)
	gohelper.setActive(arg_5_0._goOptionalItem, var_5_3)
	gohelper.setActive(arg_5_0._goCover, not var_5_1 or arg_5_3)
	gohelper.setActive(arg_5_0._goCoverClose, not var_5_1)
	gohelper.setActive(arg_5_0._goCoverOpen, var_5_1)
	gohelper.setActive(arg_5_0._simgItem.gameObject, var_5_1)
	arg_5_0._animator:Play(var_5_4)

	local var_5_5 = tonumber(PlayerModel.instance:getMyUserId()) * arg_5_1

	math.randomseed(var_5_5)

	local var_5_6 = #arg_5_0._typeList
	local var_5_7 = math.random(1, var_5_6)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._typeList) do
		gohelper.setActive(iter_5_1, iter_5_0 == var_5_7)
	end

	if not var_5_1 then
		return
	end

	arg_5_0._boxId = var_5_0:getBonusIdByPos(arg_5_1)

	local var_5_8 = Activity181Config.instance:getBoxListConfig(arg_5_0._activityId, arg_5_0._boxId)
	local var_5_9 = string.splitToNumber(var_5_8.bonus, "#")
	local var_5_10, var_5_11 = ItemModel.instance:getItemConfigAndIcon(var_5_9[1], var_5_9[2], true)

	arg_5_0._txtNum.text = tostring(var_5_9[3])

	arg_5_0._simgItem:LoadImage(var_5_11)
	UISpriteSetMgr.instance:setUiFBSprite(arg_5_0._imgQuality, "bg_pinjidi_" .. tostring(var_5_10.rare))
end

function var_0_0.setBonusFxState(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = not arg_6_1 and arg_6_2 and arg_6_0.ANI_CAN_GET or arg_6_0.ANI_IDLE

	gohelper.setActive(arg_6_0._goCover, not arg_6_1)
	arg_6_0._animator:Play(var_6_0)
end

function var_0_0.onDestroy(arg_7_0)
	arg_7_0._btnClick:RemoveClickListener()

	arg_7_0._typeList = nil
end

return var_0_0
