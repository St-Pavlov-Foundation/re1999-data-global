module("modules.logic.gm.view.GM_MainThumbnailView", package.seeall)

slot0 = class("GM_MainThumbnailView")

function slot0.register()
	uv0.MainThumbnailRecommendView_register(MainThumbnailRecommendView)
	uv0.MainThumbnailBannerContent_register(MainThumbnailBannerContent)
end

function slot0.MainThumbnailRecommendView_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(slot0, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(slot0, "onOpen")
	GMMinusModel.instance:saveOriginalFunc(slot0, "_inOpenTime")
	GMMinusModel.instance:saveOriginalFunc(slot0, "_startAutoSwitch")
	GMMinusModel.instance:saveOriginalFunc(slot0, "_sort")

	function slot0._editableInitView(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(slot0)
	end

	function slot0.addEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(slot0)
		GM_MainThumbnailRecommendViewContainer.addEvents(slot0)
	end

	function slot0.removeEvents(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(slot0)
		GM_MainThumbnailRecommendViewContainer.removeEvents(slot0)
	end

	function slot0.onOpen(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "onOpen", ...)
		slot0:_gm_stopBannerLoopAnimUpdate()
	end

	function slot0._inOpenTime(slot0, slot1, ...)
		if GM_MainThumbnailRecommendView.s_ShowAllBanner then
			if not slot1 then
				return true
			end

			slot2 = ServerTime.now()
			slot5 = string.nilorempty(slot1.onlineTime) and slot2 or TimeUtil.stringToTimestamp(slot1.onlineTime)

			if (string.nilorempty(slot1.offlineTime) and slot2 or TimeUtil.stringToTimestamp(slot1.offlineTime)) < slot2 then
				return false
			end

			return slot1.isOffline == 0
		else
			return GMMinusModel.instance:callOriginalSelfFunc(slot0, "_inOpenTime", slot1, ...)
		end
	end

	function slot0._startAutoSwitch(slot0, ...)
		if not GM_MainThumbnailRecommendView.s_StopBannerLoopAnim then
			return GMMinusModel.instance:callOriginalSelfFunc(slot0, "_startAutoSwitch", ...)
		end
	end

	function slot0._sort(slot0, slot1)
		if GM_MainThumbnailRecommendView.s_ShowAllBanner then
			slot2 = ServerTime.now()

			if (string.nilorempty(slot0.onlineTime) and slot2 or TimeUtil.stringToTimestamp(slot0.onlineTime)) ~= (string.nilorempty(slot1.onlineTime) and slot2 or TimeUtil.stringToTimestamp(slot1.onlineTime)) then
				return slot4 < slot3
			end

			return slot0.order < slot1.order
		else
			return GMMinusModel.instance:callOriginalStaticFunc(uv0, "_sort", slot0, slot1)
		end
	end

	function slot0._gm_showAllBannerUpdate(slot0)
		slot0:_clearPages()
		slot0:_initPages()
		slot0:_gm_stopBannerLoopAnimUpdate()
	end

	function slot0._gm_showAllTabIdUpdate(slot0)
		slot0:_clearPages()
		slot0:_initPages()
		slot0:_gm_stopBannerLoopAnimUpdate()
	end

	function slot0._gm_stopBannerLoopAnimUpdate(slot0)
		if GM_MainThumbnailRecommendView.s_StopBannerLoopAnim then
			TaskDispatcher.cancelTask(slot0._onSwitch, slot0)
		else
			slot0:_startAutoSwitch()
		end
	end
end

function slot0.MainThumbnailBannerContent_register(slot0)
	GMMinusModel.instance:saveOriginalFunc(slot0, "loadBanner")

	function slot0.loadBanner(slot0, ...)
		GMMinusModel.instance:callOriginalSelfFunc(slot0, "loadBanner", ...)

		if GM_MainThumbnailRecommendView.s_ShowAllTabId then
			slot2 = gohelper.getRichColorText("==========> id:" .. tostring(slot1.id), "#00FF00") .. slot0._config.des
		end

		slot0._txtdesc.text = slot2

		gohelper.setActive(slot0._txtdesc.gameObject, GM_MainThumbnailRecommendView.s_ShowAllTabId)
	end
end

return slot0
