module("modules.logic.playercard.view.comp.PlayerCardBaseInfoItem", package.seeall)

local var_0_0 = class("PlayerCardBaseInfoItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gohero = gohelper.findChild(arg_1_0.viewGO, "#go_role")
	arg_1_0._txthero = gohelper.findChildText(arg_1_0.viewGO, "#go_role/txt_role")
	arg_1_0._txtheronum = gohelper.findChildText(arg_1_0.viewGO, "#go_role/txt_role/#txt_num")
	arg_1_0._goothers = gohelper.findChild(arg_1_0.viewGO, "#go_others")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "select")
	arg_1_0._txtbase = gohelper.findChildText(arg_1_0.viewGO, "#go_others/#txt_base")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#go_others/layout/#txt_num")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#go_others/layout/#txt_dec")
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
	return
end

function var_0_0._editableAddEvents(arg_5_0)
	return
end

function var_0_0._editableRemoveEvents(arg_6_0)
	return
end

function var_0_0.onUpdateMO(arg_7_0, arg_7_1)
	arg_7_0.mo = arg_7_1
	arg_7_0.config = arg_7_1.config
	arg_7_0.playercardinfo = arg_7_0.mo.info
	arg_7_0.index = arg_7_0.mo.index
	arg_7_0.type = arg_7_0.config.type

	arg_7_0:refreshItem()

	local var_7_0 = PlayerCardBaseInfoModel.instance:getSelectIndex(arg_7_0.index)

	arg_7_0._txtorder.text = tostring(var_7_0)

	if var_7_0 then
		gohelper.setActive(arg_7_0._goselect, true)
	else
		gohelper.setActive(arg_7_0._goselect, false)
		gohelper.setActive(arg_7_0._goselecteffect, false)
	end
end

function var_0_0.refreshItem(arg_8_0)
	if arg_8_0.index == PlayerCardEnum.RightContent.HeroCount then
		arg_8_0._isHeroNum = true
	else
		arg_8_0._isHeroNum = false
	end

	gohelper.setActive(arg_8_0._gohero, arg_8_0._isHeroNum)
	gohelper.setActive(arg_8_0._goothers, not arg_8_0._isHeroNum)

	if arg_8_0._isHeroNum then
		arg_8_0._txthero.text = arg_8_0.config.name
		arg_8_0._txtheronum.text = arg_8_0.playercardinfo:getHeroCount()
		arg_8_0.chesslist = arg_8_0:getUserDataTb_()
		arg_8_0.chesslist = arg_8_0.chesslist or {}

		if not (#arg_8_0.chesslist > 0) then
			for iter_8_0 = 1, 5 do
				arg_8_0.chesslist[iter_8_0] = gohelper.findChildImage(arg_8_0._gohero, "collection/collection" .. iter_8_0 .. "/#image_full")
			end
		end

		local var_8_0, var_8_1, var_8_2, var_8_3, var_8_4 = arg_8_0.playercardinfo:getHeroRarePercent()

		arg_8_0.chesslist[1].fillAmount = var_8_0 or 100
		arg_8_0.chesslist[2].fillAmount = var_8_1 or 100
		arg_8_0.chesslist[3].fillAmount = var_8_2 or 100
		arg_8_0.chesslist[4].fillAmount = var_8_3 or 100
		arg_8_0.chesslist[5].fillAmount = var_8_4 or 100
	else
		arg_8_0._txtbase.text = arg_8_0.config.name

		local var_8_5, var_8_6 = arg_8_0.playercardinfo:getBaseInfoByIndex(arg_8_0.index, true)

		arg_8_0._txtnum.text = var_8_5
		arg_8_0._txtdesc.text = var_8_6 or ""
	end
end

function var_0_0._btnclickOnClick(arg_9_0)
	if arg_9_0.index == PlayerCardEnum.RightContent.HeroCount then
		GameFacade.showToast(ToastEnum.PlayerCardCanotClick)

		return
	end

	PlayerCardBaseInfoModel.instance:clickItem(arg_9_0.index)
	gohelper.setActive(arg_9_0._goselecteffect, true)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_carddisappear)
end

function var_0_0.onSelect(arg_10_0, arg_10_1)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
