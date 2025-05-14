module("modules.logic.rouge.view.RougeResultView", package.seeall)

local var_0_0 = class("RougeResultView", BaseView)

var_0_0.BeginType = 1
var_0_0.MinMiddleType = 2
var_0_0.MaxMiddleType = 5
var_0_0.EndType = 6
var_0_0.StartResultIndex = 1
var_0_0.OnePageShowResultCount = 2

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "Content/#txt_dec")
	arg_1_0._goevent = gohelper.findChild(arg_1_0.viewGO, "Content/#go_event")
	arg_1_0._goitem1 = gohelper.findChild(arg_1_0.viewGO, "Content/#go_event/#go_item1")
	arg_1_0._txtevent = gohelper.findChildText(arg_1_0.viewGO, "Content/#go_event/#go_item1/scroll_desc/viewport/#txt_event")
	arg_1_0._goitem2 = gohelper.findChild(arg_1_0.viewGO, "Content/#go_event/#go_item2")
	arg_1_0._goitem3 = gohelper.findChild(arg_1_0.viewGO, "Content/#go_event/#go_item3")
	arg_1_0._goitem4 = gohelper.findChild(arg_1_0.viewGO, "Content/#go_event/#go_item4")
	arg_1_0._gofail = gohelper.findChild(arg_1_0.viewGO, "Content/#go_fail")
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "Content/#go_fail/#simage_mask")
	arg_1_0._simagemask2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Content/#go_fail/#simage_mask2")
	arg_1_0._gosuccess = gohelper.findChild(arg_1_0.viewGO, "Content/#go_success")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "Content/#go_arrow")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Content/Title/#txt_Title")
	arg_1_0._simagerightmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "Content/img_dec/#simage_rightmask")
	arg_1_0._simageleftmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "Content/img_dec/#simage_leftmask")
	arg_1_0._simagerightmask2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Content/img_dec/#simage_rightmask2")
	arg_1_0._simageleftmask2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Content/img_dec/#simage_leftmask2")
	arg_1_0._simagepoint = gohelper.findChildSingleImage(arg_1_0.viewGO, "Content/img_dec/#simage_point")
	arg_1_0._simagepoint2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Content/img_dec/#simage_point2")
	arg_1_0._btnskip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Content/#btn_skip")
	arg_1_0._imageskip = gohelper.findChildImage(arg_1_0.viewGO, "Content/#btn_skip/#image_skip")
	arg_1_0._btnnext = gohelper.findChildButton(arg_1_0.viewGO, "Content/#btn_next")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnskip:AddClickListener(arg_2_0._btnskipOnClick, arg_2_0)
	arg_2_0._btnnext:AddClickListener(arg_2_0._btnnextOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnskip:RemoveClickListener()
	arg_3_0._btnnext:RemoveClickListener()
end

function var_0_0._btnskipOnClick(arg_4_0)
	RougeController.instance:openRougeSettlementView()
end

function var_0_0._btnnextOnClick(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.playStartSettlementTxtAudio, arg_5_0)

	if arg_5_0._isSwitch2EndingView then
		RougeController.instance:openRougeSettlementView()
	else
		local var_5_0 = arg_5_0._curEventEndIndex + 1

		if arg_5_0:isHasNeedShowResultItem(var_5_0) then
			arg_5_0:try2ShowResult(var_5_0)
			AudioMgr.instance:trigger(AudioEnum.UI.NextShowSettlementTxt)
		else
			arg_5_0:switch2Ending()
			AudioMgr.instance:trigger(AudioEnum.UI.ShowEndingTxt)
		end
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._isSwitch2EndingView = false
	arg_6_0._curEventEndIndex = 0
	arg_6_0._configMap = arg_6_0:buildConfigMap()
	arg_6_0._descList = arg_6_0:getTriggerConfigs()
end

function var_0_0.onOpen(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.SettlementCloseWindow)
end

local var_0_1 = 2

function var_0_0.onOpenFinish(arg_8_0)
	arg_8_0:onBeforeShowResultContent()
	TaskDispatcher.cancelTask(arg_8_0.playStartSettlementTxtAudio, arg_8_0)
	TaskDispatcher.runDelay(arg_8_0.playStartSettlementTxtAudio, arg_8_0, var_0_1)
end

function var_0_0.playStartSettlementTxtAudio(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.StartShowSettlementTxt)
end

function var_0_0.onUpdateParam(arg_10_0)
	arg_10_0:onBeforeShowResultContent()

	arg_10_0._isSwitch2EndingView = false
	arg_10_0._curEventEndIndex = 0
end

function var_0_0.onBeforeShowResultContent(arg_11_0)
	local var_11_0 = arg_11_0:filterTypeGroupCfgs(var_0_0.BeginType)

	if var_11_0 then
		arg_11_0._txtdec.text = var_11_0 and var_11_0[1]

		gohelper.setActive(arg_11_0._txtdec.gameObject, true)
	end

	gohelper.setActive(arg_11_0._gofail, false)
	gohelper.setActive(arg_11_0._gosuccess, false)
	gohelper.setActive(arg_11_0._goarrow, false)
	gohelper.setActive(arg_11_0._goevent, false)
end

function var_0_0.showRougeResultList(arg_12_0)
	arg_12_0:try2ShowResult(var_0_0.StartResultIndex)
	gohelper.setActive(arg_12_0._goarrow, true)
	gohelper.setActive(arg_12_0._txtdec.gameObject, false)
end

function var_0_0.buildConfigMap(arg_13_0)
	local var_13_0 = RougeModel.instance:getRougeResult()
	local var_13_1 = var_13_0 and var_13_0.season
	local var_13_2 = lua_rouge_result.configDict[var_13_1]
	local var_13_3 = {}

	if var_13_2 then
		for iter_13_0, iter_13_1 in pairs(var_13_2) do
			local var_13_4 = iter_13_1.type

			var_13_3[var_13_4] = var_13_3[var_13_4] or {}

			table.insert(var_13_3[var_13_4], iter_13_1)
		end
	end

	for iter_13_2, iter_13_3 in pairs(var_13_3) do
		table.sort(iter_13_3, arg_13_0.configSortFunction)
	end

	return var_13_3
end

function var_0_0.configSortFunction(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.priority
	local var_14_1 = arg_14_1.priority

	if var_14_0 ~= var_14_1 then
		return var_14_0 < var_14_1
	end

	return arg_14_0.id < arg_14_1.id
end

local var_0_2 = 3

function var_0_0.getTriggerConfigs(arg_15_0)
	local var_15_0 = {}

	for iter_15_0 = var_0_0.MinMiddleType, var_0_0.MaxMiddleType do
		local var_15_1 = arg_15_0:filterTypeGroupCfgs(iter_15_0)

		if var_15_1 and #var_15_1 > 0 then
			local var_15_2 = {
				eventType = iter_15_0,
				contents = var_15_1
			}

			table.insert(var_15_0, var_15_2)
		end
	end

	return var_15_0
end

function var_0_0.filterTypeGroupCfgs(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0._configMap and arg_16_0._configMap[arg_16_1]

	if not var_16_0 then
		return
	end

	local var_16_1 = {}
	local var_16_2 = 0

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_3 = arg_16_0:tryFilterTrigger(iter_16_1)

		if not string.nilorempty(var_16_3) then
			table.insert(var_16_1, var_16_3)

			var_16_2 = var_16_2 + 1

			if var_16_2 >= var_0_2 then
				break
			end
		end
	end

	return var_16_1
end

function var_0_0.tryFilterTrigger(arg_17_0, arg_17_1)
	if not arg_17_1 then
		return
	end

	local var_17_0 = {
		0
	}

	if not string.nilorempty(arg_17_1.triggerParam) then
		var_17_0 = string.splitToNumber(arg_17_1.triggerParam, "#")
	end

	local var_17_1 = {
		RougeSettlementTriggerHelper.isResultTrigger(arg_17_1.trigger, unpack(var_17_0))
	}
	local var_17_2 = var_17_1 and var_17_1[1] ~= nil
	local var_17_3 = arg_17_0:checkIsTriggerDefaultVisible(arg_17_1)

	if var_17_2 or var_17_3 then
		return (GameUtil.getSubPlaceholderLuaLang(arg_17_1.desc, var_17_1))
	end
end

function var_0_0.checkIsTriggerDefaultVisible(arg_18_0, arg_18_1)
	return arg_18_1 and arg_18_1.priority == 0
end

function var_0_0.try2ShowResult(arg_19_0, arg_19_1)
	if not arg_19_0._descList then
		return
	end

	local var_19_0 = #arg_19_0._descList

	if var_19_0 < arg_19_1 then
		return
	end

	local var_19_1 = arg_19_1 + var_0_0.OnePageShowResultCount - 1

	var_19_1 = var_19_0 < var_19_1 and var_19_0 or var_19_1

	arg_19_0:setAllResultItemVisible(false)

	for iter_19_0 = arg_19_1, var_19_1 do
		local var_19_2 = arg_19_0._descList[iter_19_0]
		local var_19_3 = arg_19_0:getOrCreateResultItem(iter_19_0)

		arg_19_0:refreshResultContent(var_19_3, var_19_2)
	end

	arg_19_0._curEventEndIndex = var_19_1

	gohelper.setActive(arg_19_0._goevent, true)
	gohelper.setActive(arg_19_0._txtdec.gameObject, false)
end

function var_0_0.getOrCreateResultItem(arg_20_0, arg_20_1)
	return arg_20_0["_goitem" .. arg_20_1]
end

function var_0_0.setAllResultItemVisible(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._goevent.transform.childCount

	for iter_21_0 = 1, var_21_0 do
		gohelper.setActive(arg_21_0._goevent.transform:GetChild(iter_21_0 - 1), arg_21_1)
	end
end

local var_0_3 = {
	nil,
	"rouge_result_icon_box",
	"rouge_result_icon_beasts",
	"rouge_result_icon_party",
	"rouge_result_icon_location"
}

function var_0_0.refreshResultContent(arg_22_0, arg_22_1, arg_22_2)
	if not arg_22_1 or not arg_22_2 then
		return
	end

	local var_22_0 = arg_22_2.contents
	local var_22_1 = table.concat(var_22_0, "\n")

	gohelper.findChildText(arg_22_1, "scroll_desc/viewport/#txt_event").text = var_22_1

	local var_22_2 = var_0_3[arg_22_2.eventType]

	if var_22_2 then
		local var_22_3 = gohelper.findChildImage(arg_22_1, "#imgae_icon")

		UISpriteSetMgr.instance:setRouge2Sprite(var_22_3, var_22_2)
	end

	gohelper.setActive(arg_22_1, true)
end

function var_0_0.isHasNeedShowResultItem(arg_23_0, arg_23_1)
	return arg_23_1 <= (arg_23_0._descList and #arg_23_0._descList or 0)
end

function var_0_0.switch2Ending(arg_24_0)
	local var_24_0 = RougeModel.instance:getRougeResult()
	local var_24_1 = var_24_0 and var_24_0:isSucceed()

	gohelper.setActive(arg_24_0._gofail, not var_24_1)
	gohelper.setActive(arg_24_0._gosuccess, var_24_1)
	gohelper.setActive(arg_24_0._goarrow, false)
	arg_24_0:setAllResultItemVisible(false)

	arg_24_0._isSwitch2EndingView = true

	local var_24_2 = arg_24_0:filterTypeGroupCfgs(var_0_0.EndType)
	local var_24_3 = var_24_2 and var_24_2[1] or ""

	if var_24_1 then
		gohelper.findChildText(arg_24_0._gosuccess, "txt_success").text = var_24_3
	else
		gohelper.findChildText(arg_24_0._gofail, "txt_fail").text = var_24_3
	end
end

function var_0_0.getRougeResultCfg(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0._configMap[arg_25_1]

	if var_25_0 then
		for iter_25_0, iter_25_1 in ipairs(var_25_0) do
			if iter_25_1.season == arg_25_2 then
				return iter_25_1
			end
		end
	end
end

function var_0_0.onClose(arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0.playStartSettlementTxtAudio, arg_26_0)
end

function var_0_0.onDestroyView(arg_27_0)
	return
end

return var_0_0
