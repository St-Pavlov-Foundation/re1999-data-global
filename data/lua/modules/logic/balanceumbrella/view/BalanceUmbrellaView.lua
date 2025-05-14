module("modules.logic.balanceumbrella.view.BalanceUmbrellaView", package.seeall)

local var_0_0 = class("BalanceUmbrellaView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gonofull = gohelper.findChild(arg_1_0.viewGO, "#simage_title_normal")
	arg_1_0._gofull = gohelper.findChild(arg_1_0.viewGO, "#simage_title_finished")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._clues = arg_2_0:getUserDataTb_()
	arg_2_0._lines = arg_2_0:getUserDataTb_()
	arg_2_0._points = arg_2_0:getUserDataTb_()

	local var_2_0 = gohelper.findChild(arg_2_0.viewGO, "Clue").transform

	for iter_2_0 = 0, var_2_0.childCount - 1 do
		local var_2_1 = var_2_0:GetChild(iter_2_0)
		local var_2_2 = string.match(var_2_1.name, "clue([0-9]+)")

		if var_2_2 then
			local var_2_3 = tonumber(var_2_2)

			arg_2_0._clues[var_2_3] = var_2_1:GetComponent(typeof(UnityEngine.Animator))

			local var_2_4 = gohelper.findChildButtonWithAudio(var_2_1.gameObject, "")

			arg_2_0:addClickCb(var_2_4, arg_2_0._showDetail, arg_2_0, var_2_3)
		end
	end

	local var_2_5 = gohelper.findChild(arg_2_0.viewGO, "Line").transform

	for iter_2_1 = 0, var_2_5.childCount - 1 do
		local var_2_6 = var_2_5:GetChild(iter_2_1)
		local var_2_7, var_2_8 = string.match(var_2_6.name, "line([0-9]+)_([0-9]+)")

		if var_2_7 then
			local var_2_9 = tonumber(var_2_7)
			local var_2_10 = tonumber(var_2_8)

			arg_2_0._lines[var_2_6.name] = {
				anim = var_2_6:GetComponent(typeof(UnityEngine.Animator)),
				startIndex = var_2_9,
				endIndex = var_2_10
			}
		end

		local var_2_11 = string.match(var_2_6.name, "point([0-9]+)")

		if var_2_11 then
			local var_2_12 = tonumber(var_2_11)

			arg_2_0._points[var_2_12] = var_2_6
		end
	end
end

function var_0_0._showDetail(arg_3_0, arg_3_1)
	ViewMgr.instance:openView(ViewName.BalanceUmbrellaClueView, {
		id = arg_3_1
	})
end

function var_0_0.onOpen(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_unlock)

	local var_4_0 = BalanceUmbrellaModel.instance:isGetAllClue()

	gohelper.setActive(arg_4_0._gofull, var_4_0)
	gohelper.setActive(arg_4_0._gonofull, not var_4_0)

	arg_4_0._newIds = BalanceUmbrellaModel.instance:getAllNoPlayIds()

	UIBlockHelper.instance:startBlock("BalanceUmbrellaView_playclue", 999, arg_4_0.viewName)
	UIBlockMgrExtend.setNeedCircleMv(false)

	for iter_4_0, iter_4_1 in pairs(arg_4_0._clues) do
		if BalanceUmbrellaModel.instance:isClueUnlock(iter_4_0) and not tabletool.indexOf(arg_4_0._newIds, iter_4_0) then
			gohelper.setActive(iter_4_1, true)
		else
			gohelper.setActive(iter_4_1, false)
		end
	end

	for iter_4_2, iter_4_3 in pairs(arg_4_0._points) do
		if BalanceUmbrellaModel.instance:isClueUnlock(iter_4_2) and not tabletool.indexOf(arg_4_0._newIds, iter_4_2) then
			gohelper.setActive(iter_4_3, true)
		else
			gohelper.setActive(iter_4_3, false)
		end
	end

	for iter_4_4, iter_4_5 in pairs(arg_4_0._lines) do
		local var_4_1 = iter_4_5.startIndex
		local var_4_2 = iter_4_5.endIndex

		if BalanceUmbrellaModel.instance:isClueUnlock(var_4_1) and not tabletool.indexOf(arg_4_0._newIds, var_4_1) and BalanceUmbrellaModel.instance:isClueUnlock(var_4_2) and not tabletool.indexOf(arg_4_0._newIds, var_4_2) then
			gohelper.setActive(iter_4_5.anim, true)
		else
			gohelper.setActive(iter_4_5.anim, false)
		end
	end

	arg_4_0:beginPlayNew()
	BalanceUmbrellaModel.instance:markAllNoPlayIds()
end

function var_0_0.beginPlayNew(arg_5_0)
	local var_5_0 = table.remove(arg_5_0._newIds, 1)

	if var_5_0 then
		arg_5_0._playingId = var_5_0

		arg_5_0:playLineAnim(var_5_0)
	else
		arg_5_0:endPlayNew()
	end
end

function var_0_0.playLineAnim(arg_6_0, arg_6_1)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0._lines) do
		if iter_6_1.endIndex == arg_6_1 then
			gohelper.setActive(iter_6_1.anim, true)
			table.insert(var_6_0, iter_6_1)
		end
	end

	if #var_6_0 > 0 then
		arg_6_0._newLines = var_6_0

		for iter_6_2, iter_6_3 in pairs(arg_6_0._newLines) do
			iter_6_3.anim:Play("open", 0, 0)
		end

		TaskDispatcher.runDelay(arg_6_0._onFinishLineAnim, arg_6_0, 0.667)
	else
		arg_6_0:playImgAnim(arg_6_1)
	end
end

function var_0_0._onFinishLineAnim(arg_7_0)
	arg_7_0:playImgAnim(arg_7_0._playingId)
end

function var_0_0.playImgAnim(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0._clues[arg_8_1], true)
	arg_8_0._clues[arg_8_1]:Play("open", 0, 0)
	TaskDispatcher.runDelay(arg_8_0._imageAnimEnd, arg_8_0, 0.667)
end

function var_0_0._imageAnimEnd(arg_9_0)
	gohelper.setActive(arg_9_0._points[arg_9_0._playingId], true)
	arg_9_0:beginPlayNew()
end

function var_0_0.endPlayNew(arg_10_0)
	arg_10_0._playingId = nil

	TaskDispatcher.cancelTask(arg_10_0._onFinishLineAnim, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._imageAnimEnd, arg_10_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockHelper.instance:endBlock("BalanceUmbrellaView_playclue")
end

function var_0_0.onClose(arg_11_0)
	arg_11_0:endPlayNew()
end

return var_0_0
