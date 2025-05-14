﻿module("modules.logic.store.view.decorate.DecorateStoreDefaultShowView", package.seeall)

local var_0_0 = class("DecorateStoreDefaultShowView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobg = gohelper.findChild(arg_1_0.viewGO, "#go_bg")
	arg_1_0._goview = gohelper.findChild(arg_1_0.viewGO, "#go_view")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

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
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.viewParam.bg.transform:SetParent(arg_7_0._gobg.transform, false)
	arg_7_0.viewParam.contentBg.transform:SetParent(arg_7_0._goview.transform, false)
	arg_7_0:_openPlayerCard()
end

function var_0_0.onClose(arg_8_0)
	if arg_8_0.viewParam.callback then
		arg_8_0.viewParam.callback(arg_8_0.viewParam.callbackObj, arg_8_0.viewParam)

		arg_8_0.viewParam.callback = nil
	end
end

function var_0_0.onDestroyView(arg_9_0)
	if arg_9_0._bgGo then
		gohelper.destroy(arg_9_0._bgGo)

		arg_9_0._bgGo = nil
	end

	if arg_9_0._viewGo then
		gohelper.destroy(arg_9_0._viewGo)

		arg_9_0._viewGo = nil
	end
end

function var_0_0._openPlayerCard(arg_10_0)
	if arg_10_0.viewParam.viewCls then
		local var_10_0 = arg_10_0.viewParam.viewCls.viewGO.name
		local var_10_1 = gohelper.findChild(arg_10_0.viewParam.contentBg, "#go_typebg5/" .. var_10_0)

		if var_10_1 then
			arg_10_0.playerCardView = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_1, StorePlayerCardView)

			arg_10_0.playerCardView:onShowDecorateStoreDefault()
		end
	end
end

return var_0_0
