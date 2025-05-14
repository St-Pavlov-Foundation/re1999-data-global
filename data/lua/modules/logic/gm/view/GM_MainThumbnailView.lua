module("modules.logic.gm.view.GM_MainThumbnailView", package.seeall)

local var_0_0 = class("GM_MainThumbnailView")

function var_0_0.register()
	var_0_0.MainThumbnailRecommendView_register(MainThumbnailRecommendView)
	var_0_0.MainThumbnailBannerContent_register(MainThumbnailBannerContent)
end

function var_0_0.MainThumbnailRecommendView_register(arg_2_0)
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "onOpen")
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "_inOpenTime")
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "_startAutoSwitch")
	GMMinusModel.instance:saveOriginalFunc(arg_2_0, "_sort")

	function arg_2_0._editableInitView(arg_3_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_3_0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(arg_3_0)
	end

	function arg_2_0.addEvents(arg_4_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_4_0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(arg_4_0)
		GM_MainThumbnailRecommendViewContainer.addEvents(arg_4_0)
	end

	function arg_2_0.removeEvents(arg_5_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_5_0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(arg_5_0)
		GM_MainThumbnailRecommendViewContainer.removeEvents(arg_5_0)
	end

	function arg_2_0.onOpen(arg_6_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_6_0, "onOpen", ...)
		arg_6_0:_gm_stopBannerLoopAnimUpdate()
	end

	function arg_2_0._inOpenTime(arg_7_0, arg_7_1, ...)
		if GM_MainThumbnailRecommendView.s_ShowAllBanner then
			if not arg_7_1 then
				return true
			end

			local var_7_0 = ServerTime.now()
			local var_7_1 = TimeUtil.stringToTimestamp(arg_7_1.onlineTime)
			local var_7_2 = TimeUtil.stringToTimestamp(arg_7_1.offlineTime)
			local var_7_3

			var_7_3 = string.nilorempty(arg_7_1.onlineTime) and var_7_0 or var_7_1

			if var_7_0 > (string.nilorempty(arg_7_1.offlineTime) and var_7_0 or var_7_2) then
				return false
			end

			return arg_7_1.isOffline == 0
		else
			return GMMinusModel.instance:callOriginalSelfFunc(arg_7_0, "_inOpenTime", arg_7_1, ...)
		end
	end

	function arg_2_0._startAutoSwitch(arg_8_0, ...)
		if not GM_MainThumbnailRecommendView.s_StopBannerLoopAnim then
			return GMMinusModel.instance:callOriginalSelfFunc(arg_8_0, "_startAutoSwitch", ...)
		end
	end

	function arg_2_0._sort(arg_9_0, arg_9_1)
		if GM_MainThumbnailRecommendView.s_ShowAllBanner then
			local var_9_0 = ServerTime.now()
			local var_9_1 = string.nilorempty(arg_9_0.onlineTime) and var_9_0 or TimeUtil.stringToTimestamp(arg_9_0.onlineTime)
			local var_9_2 = string.nilorempty(arg_9_1.onlineTime) and var_9_0 or TimeUtil.stringToTimestamp(arg_9_1.onlineTime)

			if var_9_1 ~= var_9_2 then
				return var_9_2 < var_9_1
			end

			return arg_9_0.order < arg_9_1.order
		else
			return GMMinusModel.instance:callOriginalStaticFunc(arg_2_0, "_sort", arg_9_0, arg_9_1)
		end
	end

	function arg_2_0._gm_showAllBannerUpdate(arg_10_0)
		arg_10_0:_clearPages()
		arg_10_0:_initPages()
		arg_10_0:_gm_stopBannerLoopAnimUpdate()
	end

	function arg_2_0._gm_showAllTabIdUpdate(arg_11_0)
		arg_11_0:_clearPages()
		arg_11_0:_initPages()
		arg_11_0:_gm_stopBannerLoopAnimUpdate()
	end

	function arg_2_0._gm_stopBannerLoopAnimUpdate(arg_12_0)
		if GM_MainThumbnailRecommendView.s_StopBannerLoopAnim then
			TaskDispatcher.cancelTask(arg_12_0._onSwitch, arg_12_0)
		else
			arg_12_0:_startAutoSwitch()
		end
	end
end

function var_0_0.MainThumbnailBannerContent_register(arg_13_0)
	GMMinusModel.instance:saveOriginalFunc(arg_13_0, "loadBanner")

	function arg_13_0.loadBanner(arg_14_0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(arg_14_0, "loadBanner", ...)

		local var_14_0 = arg_14_0._config
		local var_14_1 = var_14_0.des

		if GM_MainThumbnailRecommendView.s_ShowAllTabId then
			var_14_1 = gohelper.getRichColorText("==========> id:" .. tostring(var_14_0.id), "#00FF00") .. var_14_1
		end

		arg_14_0._txtdesc.text = var_14_1

		gohelper.setActive(arg_14_0._txtdesc.gameObject, GM_MainThumbnailRecommendView.s_ShowAllTabId)
	end
end

return var_0_0
