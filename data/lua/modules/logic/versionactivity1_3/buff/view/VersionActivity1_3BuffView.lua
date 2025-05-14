module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3BuffView", package.seeall)

local var_0_0 = class("VersionActivity1_3BuffView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/#simage_Title")
	arg_1_0._txtDesc = gohelper.findChildText(arg_1_0.viewGO, "Left/Desc/image_DescBG/#txt_Desc")
	arg_1_0._simageWhiteCirclePath = gohelper.findChildSingleImage(arg_1_0.viewGO, "Path/#simage_WhiteCirclePath")
	arg_1_0._simageMainPath = gohelper.findChildSingleImage(arg_1_0.viewGO, "Path/#simage_MainPath")
	arg_1_0._simageBranchPath1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Path/#simage_BranchPath1")
	arg_1_0._simageBranchPath2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Path/#simage_BranchPath2")
	arg_1_0._gopath101 = gohelper.findChild(arg_1_0.viewGO, "Path/LightPath/#go_path101")
	arg_1_0._gopath102 = gohelper.findChild(arg_1_0.viewGO, "Path/LightPath/#go_path102")
	arg_1_0._gopath103 = gohelper.findChild(arg_1_0.viewGO, "Path/LightPath/#go_path103")
	arg_1_0._gopath104 = gohelper.findChild(arg_1_0.viewGO, "Path/LightPath/#go_path104")
	arg_1_0._gopath105 = gohelper.findChild(arg_1_0.viewGO, "Path/LightPath/#go_path105")
	arg_1_0._gopath201 = gohelper.findChild(arg_1_0.viewGO, "Path/LightPath/#go_path201")
	arg_1_0._gopath202 = gohelper.findChild(arg_1_0.viewGO, "Path/LightPath/#go_path202")
	arg_1_0._gopath203 = gohelper.findChild(arg_1_0.viewGO, "Path/LightPath/#go_path203")
	arg_1_0._simagePropIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "Path/Prop/#simage_PropIcon")
	arg_1_0._goBuff101 = gohelper.findChild(arg_1_0.viewGO, "Path/#go_Buff101")
	arg_1_0._goBuff102 = gohelper.findChild(arg_1_0.viewGO, "Path/#go_Buff102")
	arg_1_0._goBuff103 = gohelper.findChild(arg_1_0.viewGO, "Path/#go_Buff103")
	arg_1_0._goBuff104 = gohelper.findChild(arg_1_0.viewGO, "Path/#go_Buff104")
	arg_1_0._goBuff105 = gohelper.findChild(arg_1_0.viewGO, "Path/#go_Buff105")
	arg_1_0._goBuff201 = gohelper.findChild(arg_1_0.viewGO, "Path/#go_Buff201")
	arg_1_0._goBuff202 = gohelper.findChild(arg_1_0.viewGO, "Path/#go_Buff202")
	arg_1_0._goBuff203 = gohelper.findChild(arg_1_0.viewGO, "Path/#go_Buff203")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")

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

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simageFullBG:LoadImage(ResUrl.getActivity1_3BuffIcon("v1a3_buffview_fullbg"))
	arg_4_0._simageWhiteCirclePath:LoadImage(ResUrl.getActivity1_3BuffIcon("v1a3_buffview_whitecirclepath"))

	local var_4_0, var_4_1 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Currency, Activity126Enum.buffCurrencyId)

	if not string.nilorempty(var_4_1) then
		arg_4_0._simagePropIcon:LoadImage(var_4_1)
	end

	arg_4_0:_addAllBuff()
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:addEventCb(Activity126Controller.instance, Activity126Event.onUnlockBuffReply, arg_5_0._onUnlockBuffReply, arg_5_0)
	arg_5_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_5_0._onCurrencyChange, arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_sky_open)
end

function var_0_0._onCurrencyChange(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._buffList) do
		iter_6_1:updateStatus()
	end
end

function var_0_0._onUnlockBuffReply(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._buffList) do
		iter_7_1:onUnlockBuffReply()
	end
end

function var_0_0._addAllBuff(arg_8_0)
	arg_8_0._buffList = arg_8_0:getUserDataTb_()

	local var_8_0 = arg_8_0.viewContainer:getSetting().otherRes[1]

	for iter_8_0, iter_8_1 in ipairs(lua_activity126_buff.configList) do
		local var_8_1 = iter_8_1.id
		local var_8_2 = arg_8_0["_goBuff" .. var_8_1]
		local var_8_3 = arg_8_0["_gopath" .. var_8_1]
		local var_8_4 = arg_8_0:getResInst(var_8_0, var_8_2)
		local var_8_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_4, VersionActivity1_3BuffItem, {
			iter_8_1,
			var_8_3
		})

		arg_8_0._buffList[iter_8_0] = var_8_5
	end
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simageFullBG:UnLoadImage()
	arg_10_0._simageWhiteCirclePath:UnLoadImage()
end

return var_0_0
