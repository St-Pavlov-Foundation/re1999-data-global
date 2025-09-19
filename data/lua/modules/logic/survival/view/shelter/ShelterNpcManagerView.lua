module("modules.logic.survival.view.shelter.ShelterNpcManagerView", package.seeall)

local var_0_0 = class("ShelterNpcManagerView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goItem = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#scroll_List/Viewport/Content/#go_Item")
	arg_1_0.goSmallItem = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#scroll_List/Viewport/Content/#go_SmallItem")

	gohelper.setActive(arg_1_0.goItem, false)
	gohelper.setActive(arg_1_0.goSmallItem, false)

	arg_1_0.goFilter = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#btn_filter")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnNpcPostionChange, arg_2_0.onNpcPostionChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnNpcPostionChange, arg_3_0.onNpcPostionChange, arg_3_0)
end

function var_0_0.onNpcPostionChange(arg_4_0)
	arg_4_0:refreshView()
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:refreshFilter()
	arg_5_0:refreshView()
end

function var_0_0.refreshView(arg_6_0)
	arg_6_0:refreshList()
	arg_6_0:refreshInfoView()
end

function var_0_0.refreshList(arg_7_0)
	SurvivalShelterNpcListModel.instance:refreshList(arg_7_0._filterList)
end

function var_0_0.refreshFilter(arg_8_0)
	local var_8_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_8_0.goFilter, SurvivalFilterPart)
	local var_8_1 = {}
	local var_8_2 = lua_survival_tag_type.configList

	for iter_8_0, iter_8_1 in ipairs(var_8_2) do
		table.insert(var_8_1, {
			desc = iter_8_1.name,
			type = iter_8_1.id
		})
	end

	var_8_0:setOptionChangeCallback(arg_8_0._onFilterChange, arg_8_0)
	var_8_0:setOptions(var_8_1)
end

function var_0_0._onFilterChange(arg_9_0, arg_9_1)
	arg_9_0._filterList = arg_9_1

	arg_9_0:refreshView()
end

function var_0_0.refreshInfoView(arg_10_0)
	if not arg_10_0.infoView then
		local var_10_0 = arg_10_0.viewContainer:getRes(arg_10_0.viewContainer:getSetting().otherRes.infoView)
		local var_10_1 = gohelper.findChild(arg_10_0.viewGO, "Panel/Right/go_manageinfo")

		arg_10_0.infoView = ShelterManagerInfoView.getView(var_10_0, var_10_1, "infoView")
	end

	local var_10_2 = {
		showType = SurvivalEnum.InfoShowType.Npc,
		showId = SurvivalShelterNpcListModel.instance:getSelectNpc()
	}

	arg_10_0.infoView:refreshParam(var_10_2)
end

function var_0_0.onClose(arg_11_0)
	return
end

return var_0_0
