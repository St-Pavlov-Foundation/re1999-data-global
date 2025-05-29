module("modules.logic.summon.controller.SummonMainController", package.seeall)

local var_0_0 = class("SummonMainController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._pickHandlerMap = {
		[SummonEnum.TabContentIndex.CharNormal] = arg_2_0.pickCharNormalRes,
		[SummonEnum.TabContentIndex.EquipNormal] = arg_2_0.pickEquipNormalRes,
		[SummonEnum.TabContentIndex.CharNewbie] = arg_2_0.pickCharNewbieRes,
		[SummonEnum.TabContentIndex.CharProbUp] = arg_2_0.pickCharProbUpRes,
		[SummonEnum.TabContentIndex.EquipProbUp] = arg_2_0.pickEquipProbUpRes
	}
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_4_0.handleDailyRefresh, arg_4_0)
end

function var_0_0.openSummonView(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	SummonMainModel.instance:initCategory()
	SummonMainModel.instance:resetTabResSettings()
	SummonMainCategoryListModel.instance:initCategory()

	local var_5_0 = arg_5_1 and arg_5_1.jumpPoolId

	var_5_0 = var_5_0 or arg_5_0:trySetDefaultPoolId(arg_5_1)

	if var_5_0 then
		SummonMainModel.instance:trySetSelectPoolId(var_5_0)
	end

	if arg_5_1 and arg_5_1.jumpPoolId ~= nil and arg_5_1.defaultTabIds == nil then
		local var_5_1 = SummonConfig.instance:getSummonPool(arg_5_1.jumpPoolId)

		if var_5_1 then
			local var_5_2 = SummonMainModel.instance:getADPageTabIndexForUI(var_5_1)

			arg_5_1.defaultTabIds = {}
			arg_5_1.defaultTabIds[3] = var_5_2
		end
	end

	arg_5_0._openByEnterScene = arg_5_2

	logNormal("openSummonView jumpPoolId = " .. tostring(var_5_0))

	arg_5_0._callbackOpen = arg_5_3
	arg_5_0._callbackObjOpen = arg_5_4

	ViewMgr.instance:openView(ViewName.SummonView)

	if arg_5_1 and arg_5_1.hideADView then
		arg_5_0:onViewOpened(ViewName.SummonADView)
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_5_0.onViewOpened, arg_5_0)
		ViewMgr.instance:openView(ViewName.SummonADView, arg_5_1)
	end

	if SummonMainModel.equipPoolIsValid() and SummonModel.instance:getFreeEquipSummon() then
		SummonController.instance:dispatchEvent(SummonEvent.GuideEquipPool)
	end
end

function var_0_0.trySetDefaultPoolId(arg_6_0, arg_6_1)
	local var_6_0

	if arg_6_1 == nil or arg_6_1.defaultTabIds == nil then
		local var_6_1 = SummonMainModel.instance:getFirstValidPool()

		if var_6_1 then
			local var_6_2 = var_6_1.id

			if arg_6_1 ~= nil then
				arg_6_1.jumpPoolId = var_6_2
			end

			return var_6_2
		end
	end
end

function var_0_0.onViewOpened(arg_7_0, arg_7_1)
	if arg_7_1 == ViewName.SummonADView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_7_0.onViewOpened, arg_7_0)

		if arg_7_0._callbackOpen then
			arg_7_0._callbackOpen(arg_7_0._callbackObjOpen)
		end

		arg_7_0._callbackOpen = nil
		arg_7_0._callbackObjOpen = nil
	end
end

function var_0_0.sendStartSummon(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	SummonController.instance:setSendPoolId(arg_8_1)

	arg_8_0._needGetInfo = false

	if arg_8_3 then
		local var_8_0 = SummonModel.instance:getFreeEquipSummon()

		SummonModel.instance:setSendEquipFreeSummon(var_8_0)
		SummonRpc.instance:sendSummonRequest(arg_8_1, arg_8_2)

		if var_8_0 then
			arg_8_0._needGetInfo = true
		end
	else
		SummonModel.instance:setSendEquipFreeSummon(false)
		SummonRpc.instance:sendSummonRequest(arg_8_1, arg_8_2)

		if arg_8_4 then
			arg_8_0._needGetInfo = true
		end
	end
end

function var_0_0.getNeedGetInfo(arg_9_0)
	return arg_9_0._needGetInfo
end

function var_0_0.openSummonDetail(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)

	local var_10_0 = {
		poolId = arg_10_1.id,
		poolDetailId = arg_10_1.poolDetail,
		poolAwardTime = arg_10_1.awardTime,
		summonSimulationActId = arg_10_3
	}

	if SummonConfig.poolIsLuckyBag(arg_10_1.id) then
		if arg_10_2 then
			var_10_0.luckyBagId = arg_10_2
		end

		ViewMgr.instance:openView(ViewName.SummonLuckyBagDetailView, var_10_0)
	elseif arg_10_1.type == SummonEnum.Type.CustomPick or arg_10_1.type == SummonEnum.Type.StrongCustomOnePick then
		ViewMgr.instance:openView(ViewName.SummonCustomPickDetailView, var_10_0)
	else
		ViewMgr.instance:openView(ViewName.SummonPoolDetailView, var_10_0)
	end
end

function var_0_0.isFromSceneOpen(arg_11_0)
	return arg_11_0._openByEnterScene
end

function var_0_0.pickAllUIPreloadRes(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = SummonMainModel.getValidPools()

	for iter_12_0 = 1, tabletool.len(var_12_2) do
		local var_12_3 = var_12_2[iter_12_0]
		local var_12_4 = var_12_3.customClz

		if not string.nilorempty(var_12_4) then
			local var_12_5 = SummonCharacterProbUpPreloadConfig.getPreLoadListByName(var_12_4)

			if var_12_5 == nil then
				local var_12_6 = SummonMainModel.instance:getADPageTabIndexForUI(var_12_3)

				if var_12_6 then
					var_12_5 = SummonMainModel.instance:getUIClassDef(var_12_6).preloadList
				end
			end

			if var_12_5 ~= nil then
				for iter_12_1, iter_12_2 in ipairs(var_12_5) do
					if not var_12_0[iter_12_2] then
						table.insert(var_12_1, iter_12_2)

						var_12_0[iter_12_2] = true
					end
				end
			end
		end
	end

	return var_12_1
end

function var_0_0.getCurPoolPreloadRes(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = SummonMainModel.instance:getCurId()
	local var_13_3 = SummonConfig.instance:getSummonPool(var_13_2)

	if var_13_3 then
		local var_13_4 = var_13_3.customClz

		if not string.nilorempty(var_13_4) then
			local var_13_5 = SummonCharacterProbUpPreloadConfig.getPreLoadListByName(var_13_4)

			if var_13_5 == nil then
				local var_13_6 = SummonMainModel.getADPageTabIndex(var_13_3)
				local var_13_7 = SummonMainModel.defaultUIClzMap[var_13_6]
				local var_13_8

				if not string.nilorempty(var_13_3.customClz) then
					var_13_8 = _G[var_13_3.customClz]
				end

				var_13_8 = var_13_8 or var_13_7
				var_13_5 = var_13_8.preloadList
			end

			if var_13_5 ~= nil then
				for iter_13_0, iter_13_1 in ipairs(var_13_5) do
					if not var_13_0[iter_13_1] then
						table.insert(var_13_1, iter_13_1)

						var_13_0[iter_13_1] = true
					end
				end
			end
		end
	end

	return var_13_1
end

function var_0_0.handleDailyRefresh(arg_14_0)
	SummonRpc.instance:sendGetSummonInfoRequest()
end

var_0_0.instance = var_0_0.New()

return var_0_0
