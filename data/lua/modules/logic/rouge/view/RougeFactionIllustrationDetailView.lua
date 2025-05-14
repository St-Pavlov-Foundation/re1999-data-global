module("modules.logic.rouge.view.RougeFactionIllustrationDetailView", package.seeall)

local var_0_0 = class("RougeFactionIllustrationDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "#go_progress")
	arg_1_0._goprogressitem = gohelper.findChild(arg_1_0.viewGO, "#go_progress/#go_progressitem")
	arg_1_0._scrollview = gohelper.findChildScrollRect(arg_1_0.viewGO, "Middle/#scroll_view")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "Middle/#scroll_view/Viewport/#go_Content")
	arg_1_0._btnRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Middle/#btn_Right")
	arg_1_0._btnLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Middle/#btn_Left")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnRight:AddClickListener(arg_2_0._btnRightOnClick, arg_2_0)
	arg_2_0._btnLeft:AddClickListener(arg_2_0._btnLeftOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnRight:RemoveClickListener()
	arg_3_0._btnLeft:RemoveClickListener()
end

local var_0_1 = 0.3

function var_0_0._btnRightOnClick(arg_4_0)
	arg_4_0._index = arg_4_0._index + 1

	if arg_4_0._index > arg_4_0._num then
		arg_4_0._index = 1
	end

	TaskDispatcher.cancelTask(arg_4_0._delayUpdateInfo, arg_4_0)
	TaskDispatcher.runDelay(arg_4_0._delayUpdateInfo, arg_4_0, var_0_1)
	arg_4_0._aniamtor:Play("switch_l", 0, 0)
end

function var_0_0._btnLeftOnClick(arg_5_0)
	arg_5_0._index = arg_5_0._index - 1

	if arg_5_0._index < 1 then
		arg_5_0._index = arg_5_0._num
	end

	TaskDispatcher.cancelTask(arg_5_0._delayUpdateInfo, arg_5_0)
	TaskDispatcher.runDelay(arg_5_0._delayUpdateInfo, arg_5_0, var_0_1)
	arg_5_0._aniamtor:Play("switch_r", 0, 0)
end

function var_0_0._delayUpdateInfo(arg_6_0)
	arg_6_0:_updateInfo(arg_6_0._list[arg_6_0._index])
end

function var_0_0._editableInitView(arg_7_0)
	local var_7_0 = arg_7_0.viewContainer:getSetting().otherRes[1]
	local var_7_1 = arg_7_0:getResInst(var_7_0, arg_7_0._goContent)

	arg_7_0._item = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_1, RougeFactionIllustrationDetailItem)

	local var_7_2 = RougeOutsideModel.instance:getSeasonStyleInfoList()

	arg_7_0._list = {}

	for iter_7_0, iter_7_1 in ipairs(var_7_2) do
		if iter_7_1.isUnLocked then
			table.insert(arg_7_0._list, iter_7_1.styleCO)
		end
	end

	arg_7_0._num = #arg_7_0._list
	arg_7_0._aniamtor = gohelper.onceAddComponent(arg_7_0.viewGO, gohelper.Type_Animator)

	arg_7_0:_initProgressItems()
end

function var_0_0._initProgressItems(arg_8_0)
	arg_8_0._itemList = arg_8_0:getUserDataTb_()

	for iter_8_0 = 1, arg_8_0._num do
		local var_8_0 = gohelper.cloneInPlace(arg_8_0._goprogressitem)
		local var_8_1 = arg_8_0:getUserDataTb_()

		var_8_1.empty = gohelper.findChild(var_8_0, "empty")
		var_8_1.light = gohelper.findChild(var_8_0, "light")

		gohelper.setActive(var_8_0, true)

		arg_8_0._itemList[iter_8_0] = var_8_1
	end
end

function var_0_0._showProgressItem(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._itemList) do
		gohelper.setActive(iter_9_1.empty, iter_9_0 ~= arg_9_1)
		gohelper.setActive(iter_9_1.light, iter_9_0 == arg_9_1)
	end
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0.onOpen(arg_11_0)
	local var_11_0 = arg_11_0.viewParam

	arg_11_0._index = tabletool.indexOf(arg_11_0._list, var_11_0) or 1

	arg_11_0:_updateInfo(var_11_0)
end

function var_0_0._updateInfo(arg_12_0, arg_12_1)
	arg_12_0._mo = arg_12_1

	arg_12_0._item:onUpdateMO(arg_12_1)
	arg_12_0:_showProgressItem(arg_12_0._index)
end

function var_0_0.onClose(arg_13_0)
	return
end

function var_0_0.onDestroyView(arg_14_0)
	TaskDispatcher.cancelTask(arg_14_0._delayUpdateInfo, arg_14_0)
end

return var_0_0
