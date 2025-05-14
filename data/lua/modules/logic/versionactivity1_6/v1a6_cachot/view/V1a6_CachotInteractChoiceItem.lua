module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotInteractChoiceItem", package.seeall)

local var_0_0 = class("V1a6_CachotInteractChoiceItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._gonormal = gohelper.findChild(arg_1_1, "normal")
	arg_1_0._goselect = gohelper.findChild(arg_1_1, "select")
	arg_1_0._golock = gohelper.findChild(arg_1_1, "locked")
	arg_1_0._clickNormal = gohelper.findChildButtonWithAudio(arg_1_1, "normal/click")
	arg_1_0._clickSelect = gohelper.findChildButtonWithAudio(arg_1_1, "select/click")
	arg_1_0._clickLock = gohelper.findChildButtonWithAudio(arg_1_1, "locked/click")
	arg_1_0._txtnormaltitle = gohelper.findChildTextMesh(arg_1_1, "normal/layout/#txt_info1")
	arg_1_0._txtnormaldesc = gohelper.findChildTextMesh(arg_1_1, "normal/layout/#txt_info2")
	arg_1_0._txtnormalinfo = gohelper.findChildTextMesh(arg_1_1, "normal/layout/tipsbg/#txt_tips")
	arg_1_0._gonormallockIcon = gohelper.findChild(arg_1_1, "normal/#txt_tips/icon")
	arg_1_0._txtselecttitle = gohelper.findChildTextMesh(arg_1_1, "select/layout/info1")
	arg_1_0._txtselectdesc = gohelper.findChildTextMesh(arg_1_1, "select/layout/info2")
	arg_1_0._txtselectinfo = gohelper.findChildTextMesh(arg_1_1, "select/layout/tips")
	arg_1_0._txtlocktitle = gohelper.findChildTextMesh(arg_1_1, "locked/layout/#txt_info1")
	arg_1_0._txtlockdesc = gohelper.findChildTextMesh(arg_1_1, "locked/layout/#txt_info2")
	arg_1_0._txtlockinfo = gohelper.findChildTextMesh(arg_1_1, "locked/layout/tipsbg/#txt_tips")
	arg_1_0._anim = arg_1_1:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._clickNormal:AddClickListener(arg_2_0._selectThis, arg_2_0)
	arg_2_0._clickSelect:AddClickListener(arg_2_0._selectChoice, arg_2_0)
	arg_2_0._clickLock:AddClickListener(arg_2_0._selectThis, arg_2_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.SelectChoice, arg_2_0._onChoiceSelect, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._clickNormal:RemoveClickListener()
	arg_3_0._clickSelect:RemoveClickListener()
	arg_3_0._clickLock:RemoveClickListener()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.SelectChoice, arg_3_0._onChoiceSelect, arg_3_0)
end

function var_0_0._playOpenAnim(arg_4_0)
	arg_4_0._anim:Play("open")
	UIBlockMgr.instance:endBlock("V1a6_CachotInteractChoiceItem_close")
end

function var_0_0.updateMo(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0._co then
		arg_5_0._anim:Play("unselect", 0, 1)
		arg_5_0._anim:Update(0)
	end

	if V1a6_CachotRoomModel.instance.isFromDramaToDrama then
		UIBlockMgr.instance:startBlock("V1a6_CachotInteractChoiceItem_close")
		arg_5_0._anim:Play("close")
		TaskDispatcher.runDelay(arg_5_0._playOpenAnim, arg_5_0, 0.167)
	end

	arg_5_0._co = arg_5_1
	arg_5_0._index = arg_5_2
	arg_5_0._txtnormaltitle.text = arg_5_0._co.title
	arg_5_0._txtselecttitle.text = arg_5_0._co.title
	arg_5_0._txtlocktitle.text = arg_5_0._co.title
	arg_5_0._txtnormaldesc.text = arg_5_0._co.desc
	arg_5_0._txtselectdesc.text = arg_5_0._co.desc
	arg_5_0._txtlockdesc.text = arg_5_0._co.desc
	arg_5_0._txtnormalinfo.text = ""
	arg_5_0._txtselectinfo.text = ""
	arg_5_0._txtlockinfo.text = ""

	arg_5_0:_setIsSelect(false, true)

	arg_5_0._lockDesInfo = nil

	if not string.nilorempty(arg_5_1.condition) then
		local var_5_0 = string.splitToNumber(arg_5_1.condition, "#")

		arg_5_0._lockDesInfo = {
			V1a6_CachotChoiceConditionHelper.getConditionToast(unpack(var_5_0))
		}

		if not arg_5_0._lockDesInfo[1] then
			arg_5_0._lockDesInfo = nil
		end
	end

	if arg_5_0._lockDesInfo then
		arg_5_0._txtlockinfo.text = arg_5_0:_formatStr(lua_toast.configDict[arg_5_0._lockDesInfo[1]].tips, unpack(arg_5_0._lockDesInfo, 2))

		gohelper.setActive(arg_5_0._golock, true)
		gohelper.setActive(arg_5_0._gonormal, false)
		gohelper.setActive(arg_5_0._goselect, false)

		return
	end

	gohelper.setActive(arg_5_0._golock, false)
	gohelper.setActive(arg_5_0._gonormal, true)
	gohelper.setActive(arg_5_0._goselect, true)

	if arg_5_1.collection > 0 then
		local var_5_1 = lua_rogue_collection.configDict[arg_5_1.collection]

		if var_5_1 then
			arg_5_0._txtselectinfo.text = V1a6_CachotCollectionConfig.instance:getCollectionSkillsContent(var_5_1)
		else
			logError("没有藏品配置" .. arg_5_1.collection)
		end
	else
		local var_5_2 = lua_rogue_event.configDict[arg_5_1.event]

		if var_5_2 and var_5_2.type == V1a6_CachotEnum.EventType.CharacterRebirth then
			local var_5_3 = V1a6_CachotModel.instance:getTeamInfo()
			local var_5_4 = 0

			if var_5_3 then
				for iter_5_0, iter_5_1 in ipairs(var_5_3.lifes) do
					if iter_5_1.lifePercent <= 0 then
						var_5_4 = var_5_4 + 1
					end
				end
			end

			local var_5_5 = formatLuaLang("cachot_death_count", var_5_4)

			arg_5_0._txtnormalinfo.text = var_5_5
			arg_5_0._txtselectinfo.text = var_5_5
		end
	end
end

function var_0_0._formatStr(arg_6_0, arg_6_1, ...)
	if not ... then
		return arg_6_1
	end

	local var_6_0 = {
		...
	}

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		arg_6_1 = arg_6_1:gsub("▩" .. iter_6_0 .. "%%s", iter_6_1)
	end

	return arg_6_1
end

function var_0_0._selectThis(arg_7_0)
	if arg_7_0._lockDesInfo then
		GameFacade.showToast(unpack(arg_7_0._lockDesInfo))

		return
	end

	arg_7_0:_setIsSelect(true)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.SelectChoice, arg_7_0._index)
end

function var_0_0._setIsSelect(arg_8_0, arg_8_1, arg_8_2)
	gohelper.setActive(arg_8_0._clickNormal, not arg_8_1)
	gohelper.setActive(arg_8_0._clickSelect, arg_8_1)

	if not arg_8_2 and not arg_8_0._lockDesInfo and arg_8_0._isSelect ~= arg_8_1 then
		if arg_8_1 then
			arg_8_0._anim:Play("select")
		else
			arg_8_0._anim:Play("unselect")
		end
	end

	arg_8_0._isSelect = arg_8_1
end

function var_0_0._onChoiceSelect(arg_9_0, arg_9_1)
	if arg_9_1 ~= arg_9_0._index then
		arg_9_0:_setIsSelect(false)
	end
end

function var_0_0._selectChoice(arg_10_0)
	local var_10_0 = V1a6_CachotRoomModel.instance:getNowTopEventMo()

	if not var_10_0 then
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayChoiceDialog, arg_10_0._co.dialogId)
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.ShowHideChoice, false)
		logError("没有进行中的事件？？？？？")

		return
	end

	RogueRpc.instance:sendRogueEventSelectRequest(V1a6_CachotEnum.ActivityId, var_10_0.eventId, arg_10_0._co.id, arg_10_0._onSelectEnd, arg_10_0)
end

function var_0_0._onSelectEnd(arg_11_0)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayChoiceDialog, arg_11_0._co.dialogId)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.ShowHideChoice, false)
end

function var_0_0.onDestroy(arg_12_0)
	UIBlockMgr.instance:endBlock("V1a6_CachotInteractChoiceItem_close")
	TaskDispatcher.cancelTask(arg_12_0._playOpenAnim, arg_12_0)
end

return var_0_0
