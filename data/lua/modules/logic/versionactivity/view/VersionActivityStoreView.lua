module("modules.logic.versionactivity.view.VersionActivityStoreView", package.seeall)

local var_0_0 = class("VersionActivityStoreView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "title/#txt_time")
	arg_1_0._scrollstore = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_store")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_store/Viewport/#go_Content")
	arg_1_0._gostoreItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem")
	arg_1_0._gostoregoodsitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_righttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._scrollstore:AddOnValueChanged(arg_2_0._onScrollValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._scrollstore:RemoveOnValueChanged()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg:LoadImage(ResUrl.getVersionActivityIcon("full/img_bg"))
	gohelper.setActive(arg_4_0._gostoreItem, false)

	arg_4_0.storeItemList = arg_4_0:getUserDataTb_()
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0._onScrollValueChanged(arg_6_0)
	if #arg_6_0.storeItemList > 0 then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0.storeItemList) do
			if iter_6_0 == 1 then
				iter_6_1:refreshTagClip(arg_6_0._scrollstore)
			end
		end
	end
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_souvenir_open)
	TaskDispatcher.runRepeat(arg_7_0.refreshTime, arg_7_0, TimeUtil.OneMinuteSecond)
	arg_7_0:refreshTime()
	arg_7_0:refreshStoreContent()
	arg_7_0:_onScrollValueChanged()
end

function var_0_0.refreshStoreContent(arg_8_0)
	local var_8_0 = ActivityStoreConfig.instance:getActivityStoreGroupDict(VersionActivityEnum.ActivityId.Act107)
	local var_8_1

	for iter_8_0 = 1, #var_8_0 do
		local var_8_2 = arg_8_0.storeItemList[iter_8_0]

		if not var_8_2 then
			var_8_2 = VersionActivityStoreItem.New()

			var_8_2:onInitView(gohelper.cloneInPlace(arg_8_0._gostoreItem))
			table.insert(arg_8_0.storeItemList, var_8_2)
		end

		var_8_2:updateInfo(iter_8_0, var_8_0[iter_8_0])
	end
end

function var_0_0.refreshTime(arg_9_0)
	local var_9_0 = ActivityModel.instance:getActivityInfo()[VersionActivityEnum.ActivityId.Act107]:getRealEndTimeStamp() - ServerTime.now()
	local var_9_1 = Mathf.Floor(var_9_0 / TimeUtil.OneDaySecond)
	local var_9_2 = var_9_0 % TimeUtil.OneDaySecond
	local var_9_3 = Mathf.Floor(var_9_2 / TimeUtil.OneHourSecond)
	local var_9_4 = var_9_2 % TimeUtil.OneHourSecond
	local var_9_5 = Mathf.Ceil(var_9_4 / TimeUtil.OneMinuteSecond)

	arg_9_0._txttime.text = string.format(luaLang("versionactivitystoreview_remaintime"), var_9_1, var_9_3, var_9_5)
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.refreshTime, arg_10_0)
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simagebg:UnLoadImage()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.storeItemList) do
		iter_11_1:onDestroy()
	end
end

return var_0_0
