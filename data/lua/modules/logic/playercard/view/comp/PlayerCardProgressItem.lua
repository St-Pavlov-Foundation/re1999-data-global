module("modules.logic.playercard.view.comp.PlayerCardProgressItem", package.seeall)

local var_0_0 = class("PlayerCardProgressItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagepic = gohelper.findChildImage(arg_1_0.viewGO, "#image_pic")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "#image_icon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._txten = gohelper.findChildText(arg_1_0.viewGO, "#txt_en")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "select")
	arg_1_0._txtorder = gohelper.findChildText(arg_1_0.viewGO, "select/#txt_order")
	arg_1_0._goselecteffect = gohelper.findChild(arg_1_0.viewGO, "select/#go_click")
	arg_1_0._btnclick = gohelper.findChildButton(arg_1_0.viewGO, "#btn_click")
	arg_1_0._typeItemList = {}

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

function var_0_0._editableInitView(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(PlayerCardEnum.ProgressShowType) do
		local var_4_0 = gohelper.findChild(arg_4_0.viewGO, "progress/type" .. iter_4_1)

		gohelper.setActive(var_4_0, false)

		arg_4_0._typeItemList[iter_4_1] = var_4_0
	end

	gohelper.setActive(arg_4_0._goselect, false)
end

function var_0_0.resetType(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._typeItemList) do
		gohelper.setActive(iter_5_1, false)
	end
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0._btnclickOnClick(arg_8_0)
	PlayerCardProgressModel.instance:clickItem(arg_8_0.index)
	gohelper.setActive(arg_8_0._goselecteffect, true)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_carddisappear)
end

function var_0_0.onUpdateMO(arg_9_0, arg_9_1)
	arg_9_0.mo = arg_9_1
	arg_9_0.config = arg_9_1.config
	arg_9_0.playercardinfo = arg_9_0.mo.info
	arg_9_0.index = arg_9_0.mo.index
	arg_9_0.type = arg_9_0.config.type

	UISpriteSetMgr.instance:setPlayerCardSprite(arg_9_0._imagepic, "playercard_progress_img_" .. arg_9_0.index)
	UISpriteSetMgr.instance:setPlayerCardSprite(arg_9_0._imageicon, "playercard_progress_icon_" .. arg_9_0.index)
	arg_9_0:refreshItem()

	local var_9_0 = PlayerCardProgressModel.instance:getSelectIndex(arg_9_0.index)

	if var_9_0 then
		gohelper.setActive(arg_9_0._goselect, true)

		arg_9_0._txtorder.text = tostring(var_9_0)
	else
		gohelper.setActive(arg_9_0._goselect, false)
		gohelper.setActive(arg_9_0._goselecteffect, false)
	end
end

function var_0_0.refreshItem(arg_10_0)
	arg_10_0._txtname.text = arg_10_0.config.name
	arg_10_0._txten.text = arg_10_0.config.nameEn

	local var_10_0 = arg_10_0._typeItemList[arg_10_0.type]

	gohelper.setActive(var_10_0, true)

	if arg_10_0.type == PlayerCardEnum.ProgressShowType.Normal then
		local var_10_1 = gohelper.findChildText(var_10_0, "#txt_progress")
		local var_10_2 = gohelper.findChild(var_10_0, "none")
		local var_10_3 = arg_10_0.playercardinfo:getProgressByIndex(arg_10_0.index)
		local var_10_4 = var_10_3 ~= -1

		gohelper.setActive(var_10_2, not var_10_4)
		gohelper.setActive(var_10_1.gameObject, var_10_4)

		var_10_1.text = var_10_3
	elseif arg_10_0.type == PlayerCardEnum.ProgressShowType.Explore then
		local var_10_5 = arg_10_0.playercardinfo.exploreCollection
		local var_10_6 = gohelper.findChildText(var_10_0, "#txt_num1")
		local var_10_7 = gohelper.findChildText(var_10_0, "#txt_num2")
		local var_10_8 = gohelper.findChildText(var_10_0, "#txt_num3")

		if not string.nilorempty(var_10_5) then
			local var_10_9 = GameUtil.splitString2(var_10_5, true) or {}

			var_10_6.text = var_10_9[3][1] or 0
			var_10_7.text = var_10_9[1][1] or 0
			var_10_8.text = var_10_9[2][1] or 0
		else
			var_10_6.text = 0
			var_10_7.text = 0
			var_10_8.text = 0
		end
	elseif arg_10_0.type == PlayerCardEnum.ProgressShowType.Room then
		local var_10_10 = gohelper.findChildText(var_10_0, "#txt_num1")
		local var_10_11 = gohelper.findChildText(var_10_0, "#txt_num2")
		local var_10_12 = arg_10_0.playercardinfo.roomCollection
		local var_10_13 = string.splitToNumber(var_10_12, "#")
		local var_10_14 = var_10_13 and var_10_13[1] or 0

		if var_10_14 then
			var_10_10.text = var_10_14
		else
			var_10_10.text = 0
		end

		local var_10_15 = var_10_13 and var_10_13[2] or 0

		if var_10_15 then
			var_10_11.text = var_10_15
		else
			var_10_11.text = 0
		end
	end
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
