module("modules.logic.rouge.view.RougeTalentTreeItem", package.seeall)

local var_0_0 = class("RougeTalentTreeItem", LuaCompBase)

function var_0_0.initcomp(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._go = arg_1_1
	arg_1_0._config = arg_1_2
	arg_1_0._index = arg_1_3
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0._go, "#btn_click")
	arg_1_0._goselectframe = gohelper.findChild(arg_1_0._go, "#go_selectframe")
	arg_1_0._imagetalenicon = gohelper.findChildImage(arg_1_0._go, "#image_talenicon")
	arg_1_0._gotalenname = gohelper.findChild(arg_1_0._go, "talenname")
	arg_1_0._txttalenname = gohelper.findChildText(arg_1_0._go, "talenname/#txt_talenname")
	arg_1_0._txtprogress = gohelper.findChildText(arg_1_0._go, "#txt_progress")
	arg_1_0._golocked = gohelper.findChild(arg_1_0._go, "#go_locked")
	arg_1_0._goprogressunfull = gohelper.findChild(arg_1_0._go, "#go_progress_unfull")
	arg_1_0._goprogressunfullLight = gohelper.findChild(arg_1_0._go, "#go_progress_unfull/small_light")
	arg_1_0._imgprogress = gohelper.findChildImage(arg_1_0._go, "#go_progress_unfull/circle")
	arg_1_0._goprogressfull = gohelper.findChild(arg_1_0._go, "#go_progress_full")
	arg_1_0._golocked = gohelper.findChild(arg_1_0._go, "#go_locked")
	arg_1_0._animlock = arg_1_0._golocked:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goup = gohelper.findChild(arg_1_0._go, "#go_up")
	arg_1_0._selectGO = gohelper.findChild(arg_1_0._go, "#go_select")

	gohelper.setActive(arg_1_0._selectGO, false)

	arg_1_0._beforestatus = nil
	arg_1_0._backViewOpenTime = 0.2

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.reallyExitTalentView, arg_2_0._onBackView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0:addEventCb(RougeController.instance, RougeEvent.reallyExitTalentView, arg_3_0._onBackView, arg_3_0)
end

function var_0_0._btnclickOnClick(arg_4_0)
	RougeController.instance:dispatchEvent(RougeEvent.enterTalentView, arg_4_0._index)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0:addEvents()
end

function var_0_0.refreshItem(arg_6_0)
	local var_6_0 = RougeTalentModel.instance:checkBigNodeLock(arg_6_0._index)

	if not var_6_0 then
		arg_6_0._animlock:Update(0)
		arg_6_0._animlock:Play("idle", 0, 0)
		gohelper.setActive(arg_6_0._golocked, var_6_0)
	end

	if not arg_6_0._beforestatus then
		arg_6_0._beforestatus = var_6_0
	end

	local var_6_1 = RougeTalentModel.instance:getNextNeedUnlockTalent()
	local var_6_2 = false
	local var_6_3 = false

	if var_6_1 then
		for iter_6_0, iter_6_1 in pairs(var_6_1) do
			if iter_6_1 == arg_6_0._index then
				var_6_3 = true

				break
			end
		end
	end

	local var_6_4 = var_6_0 and var_6_3

	gohelper.setActive(arg_6_0._gotalenname, not var_6_0 or var_6_4)
	gohelper.setActive(arg_6_0._txtprogress.gameObject, var_6_4)

	local var_6_5 = RougeTalentModel.instance:checkBigNodeShowUp(arg_6_0._index)

	gohelper.setActive(arg_6_0._goup, var_6_5)

	local var_6_6 = RougeTalentModel.instance:getUnlockNumByTalent(arg_6_0._index)
	local var_6_7 = var_6_6 / RougeTalentConfig.instance:getBranchNumByTalent(arg_6_0._index)
	local var_6_8 = var_6_7 >= 1

	arg_6_0._imgprogress.fillAmount = var_6_7

	if not string.nilorempty(arg_6_0._config.icon) then
		if var_6_0 then
			UISpriteSetMgr.instance:setRougeSprite(arg_6_0._imagetalenicon, arg_6_0._config.icon .. "_locked")
		elseif var_6_6 > 0 then
			UISpriteSetMgr.instance:setRougeSprite(arg_6_0._imagetalenicon, arg_6_0._config.icon)
		else
			UISpriteSetMgr.instance:setRougeSprite(arg_6_0._imagetalenicon, arg_6_0._config.icon .. "_locked")
		end
	end

	local var_6_9 = RougeOutsideModel.instance:season()
	local var_6_10 = RougeTalentConfig.instance:getConfigByTalent(var_6_9, arg_6_0._index)
	local var_6_11 = RougeTalentModel.instance:getHadConsumeTalentPoint()

	arg_6_0._txtprogress.text = string.format("<color=%s>%s</color>", "#E99B56", var_6_11) .. "/" .. var_6_10.cost
	arg_6_0._txttalenname.text = arg_6_0._config.name

	local var_6_12 = not var_6_0 and not var_6_8
	local var_6_13 = RougeTalentModel.instance:getUnlockNumByTalent(arg_6_0._index) > 0

	gohelper.setActive(arg_6_0._goprogressunfullLight, var_6_12 and var_6_13)
	gohelper.setActive(arg_6_0._goprogressunfull, not var_6_8)
	gohelper.setActive(arg_6_0._goprogressfull, var_6_8)
end

function var_0_0._onBackView(arg_7_0)
	function arg_7_0.backopenfunc()
		TaskDispatcher.cancelTask(arg_7_0.backopenfunc, arg_7_0)

		local var_8_0 = RougeTalentModel.instance:checkBigNodeLock(arg_7_0._index)

		if arg_7_0._beforestatus ~= var_8_0 then
			gohelper.setActive(arg_7_0._golocked, true)
			arg_7_0._animlock:Update(0)
			arg_7_0._animlock:Play("unlock", 0, 0)

			arg_7_0._beforestatus = var_8_0
		end
	end

	TaskDispatcher.runDelay(arg_7_0.backopenfunc, arg_7_0, arg_7_0._backViewOpenTime)
end

function var_0_0.dispose(arg_9_0)
	arg_9_0:removeEvents()
	arg_9_0:__onDispose()
end

return var_0_0
