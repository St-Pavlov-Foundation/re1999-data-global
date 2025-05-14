module("modules.logic.seasonver.act123.view1_8.Season123_1_8SettlementTipsWork", package.seeall)

local var_0_0 = class("Season123_1_8SettlementTipsWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	arg_1_0._context = arg_1_1

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0._onCloseViewFinish, arg_1_0)

	if PopupController.instance:getPopupCount() > 0 then
		PopupController.instance:setPause("fightsuccess", false)

		arg_1_0._showPopupView = true
	else
		arg_1_0:_showEquipGet()
	end
end

function var_0_0._showEquipGet(arg_2_0)
	PopupController.instance:setPause("fightsuccess", false)

	local var_2_0 = {}

	tabletool.addValues(var_2_0, FightResultModel.instance:getFirstMaterialDataList())
	tabletool.addValues(var_2_0, FightResultModel.instance:getExtraMaterialDataList())
	tabletool.addValues(var_2_0, FightResultModel.instance:getMaterialDataList())

	local var_2_1 = {}

	for iter_2_0 = #var_2_0, 1, -1 do
		if var_2_0[iter_2_0].materilType == MaterialEnum.MaterialType.Season123EquipCard then
			local var_2_2 = table.remove(var_2_0, iter_2_0)

			table.insert(var_2_1, var_2_2.materilId)
		end
	end

	arg_2_0._showEquipCard = {}

	local var_2_3 = arg_2_0._context.onlyShowNewCard

	for iter_2_1, iter_2_2 in ipairs(var_2_1) do
		if var_2_3 then
			if Season123Model.instance:isNewEquipBookCard(iter_2_2) then
				table.insert(arg_2_0._showEquipCard, iter_2_2)
			end
		else
			table.insert(arg_2_0._showEquipCard, iter_2_2)
		end
	end

	local var_2_4 = arg_2_0._context.delayTime

	if #arg_2_0._showEquipCard > 0 then
		local var_2_5 = {}

		for iter_2_3 = #arg_2_0._showEquipCard, 1, -1 do
			local var_2_6 = arg_2_0._showEquipCard[iter_2_3]

			if var_2_5[var_2_6] then
				table.remove(arg_2_0._showEquipCard, iter_2_3)
			else
				var_2_5[var_2_6] = true
			end
		end

		TaskDispatcher.runDelay(arg_2_0._showGetCardView, arg_2_0, var_2_4)
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0._onCloseViewFinish(arg_3_0, arg_3_1)
	if arg_3_0._showPopupView then
		if PopupController.instance:getPopupCount() == 0 then
			arg_3_0._showPopupView = nil

			arg_3_0:_showEquipGet()
		end
	elseif arg_3_1 == ViewName.Season123_1_8CelebrityCardGetView then
		arg_3_0:onDone(true)
	end
end

function var_0_0._showGetCardView(arg_4_0)
	Season123Controller.instance:openSeasonCelebrityCardGetView({
		is_item_id = true,
		data = arg_4_0._showEquipCard
	})
end

function var_0_0.clearWork(arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_5_0._onCloseViewFinish, arg_5_0)
end

return var_0_0
