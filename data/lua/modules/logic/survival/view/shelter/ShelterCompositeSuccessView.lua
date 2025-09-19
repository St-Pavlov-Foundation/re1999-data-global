module("modules.logic.survival.view.shelter.ShelterCompositeSuccessView", package.seeall)

local var_0_0 = class("ShelterCompositeSuccessView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0.goInfoView = gohelper.findChild(arg_1_0.viewGO, "#go_infoview")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClose, arg_2_0.onClickCloseBtn, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnClose)
end

function var_0_0.onClickCloseBtn(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0.onOpen(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_wangshi_argus_level_finish)

	arg_5_0.itemMo = arg_5_0.viewParam and arg_5_0.viewParam.itemMo

	arg_5_0:refreshView()
end

function var_0_0.refreshView(arg_6_0)
	local var_6_0 = arg_6_0.itemMo

	if not var_6_0 then
		gohelper.setActive(arg_6_0.goInfoView, false)

		return
	end

	gohelper.setActive(arg_6_0.goInfoView, true)

	if not arg_6_0._infoPanel then
		local var_6_1 = arg_6_0.viewContainer:getSetting().otherRes.infoView
		local var_6_2 = arg_6_0.viewContainer:getResInst(var_6_1, arg_6_0.goInfoView)

		arg_6_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_2, SurvivalBagInfoPart)

		local var_6_3 = {
			[SurvivalEnum.ItemSource.Map] = SurvivalEnum.ItemSource.Info,
			[SurvivalEnum.ItemSource.Shelter] = SurvivalEnum.ItemSource.Info
		}

		arg_6_0._infoPanel:setChangeSource(var_6_3)
	end

	arg_6_0._infoPanel:updateMo(var_6_0)
end

return var_0_0
