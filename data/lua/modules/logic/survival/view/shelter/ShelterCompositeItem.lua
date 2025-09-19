module("modules.logic.survival.view.shelter.ShelterCompositeItem", package.seeall)

local var_0_0 = class("ShelterCompositeItem", ListScrollCellExtend)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.compositeView = arg_1_1.compositeView
	arg_1_0.index = arg_1_1.index
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0.goUnChoose = gohelper.findChild(arg_2_0.viewGO, "#go_unchoose")
	arg_2_0.btnAdd = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#go_unchoose/#btn_click")
	arg_2_0.goChoose = gohelper.findChild(arg_2_0.viewGO, "#go_choosed")
	arg_2_0.btnRemove = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#go_choosed/#btn_remove")
	arg_2_0.goInfoView = gohelper.findChild(arg_2_0.viewGO, "#go_choosed/#go_infoview")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:addClickCb(arg_3_0.btnAdd, arg_3_0.onClickAdd, arg_3_0)
	arg_3_0:addClickCb(arg_3_0.btnRemove, arg_3_0.onClickRemove, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0:removeClickCb(arg_4_0.btnAdd)
	arg_4_0:removeClickCb(arg_4_0.btnRemove)
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onClickAdd(arg_6_0)
	arg_6_0.compositeView:showMaterialView(arg_6_0.index)
end

function var_0_0.onClickRemove(arg_7_0)
	arg_7_0.compositeView:removeMaterialData(arg_7_0.index)
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0.itemMo = arg_8_1

	arg_8_0:refreshView()
end

function var_0_0.refreshView(arg_9_0)
	gohelper.setActive(arg_9_0.goUnChoose, arg_9_0.itemMo == nil)
	gohelper.setActive(arg_9_0.goChoose, arg_9_0.itemMo ~= nil)
	arg_9_0:refreshInfoView()
end

function var_0_0.refreshInfoView(arg_10_0)
	if not arg_10_0._infoPanel then
		local var_10_0 = arg_10_0.compositeView.viewContainer:getSetting().otherRes.infoView
		local var_10_1 = arg_10_0.compositeView.viewContainer:getResInst(var_10_0, arg_10_0.goInfoView)

		arg_10_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_1, SurvivalBagInfoPart)

		local var_10_2 = {
			[SurvivalEnum.ItemSource.Shelter] = SurvivalEnum.ItemSource.Info,
			[SurvivalEnum.ItemSource.Map] = SurvivalEnum.ItemSource.Info
		}

		arg_10_0._infoPanel:setChangeSource(var_10_2)
	end

	arg_10_0._infoPanel:updateMo(arg_10_0.itemMo)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
