module("modules.logic.fight.view.preview.SkillEditorToolsBtnView", package.seeall)

slot0 = class("SkillEditorToolsBtnView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._btntools = gohelper.findChildButton(slot0.viewGO, "right/btn_tools")
	slot0._toolsBtnList = gohelper.findChild(slot0.viewGO, "right/go_tool_btn_list")
	slot0._btnModel = gohelper.findChildButton(slot0.viewGO, "right/go_tool_btn_list/btn_model")
	slot0._gotoolroot = gohelper.findChild(slot0.viewGO, "go_tool_root")
	slot0._gotoolviewmodel = gohelper.findChild(slot0.viewGO, "go_tool_root/go_tool_view_model")
	slot0._btnText = gohelper.findChildText(slot0.viewGO, "right/btn_tools/Text")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntools:AddClickListener(slot0._onBtnTools, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntools:RemoveClickListener()

	if slot0._btns then
		for slot4, slot5 in ipairs(slot0._btns) do
			slot5:RemoveClickListener()
		end

		slot0._btns = nil
	end
end

function slot0._editableInitView(slot0)
	slot0:addToolBtn("改伤害", slot0._onClickDamage)
	slot0:addToolBtn("角色描边", slot0._onClickOutline)
	slot0:addToolBtn("开启出牌镜头", slot0._onClickPlayCardCameraAni)
	slot0:addToolBtn("移除术阵特效", slot0._onClickSuZhenSwitch)
end

function slot0._onClickDamage(slot0)
	CommonInputMO.New().title = "请输入伤害数值"
	slot1.defaultInput = SkillEditorStepBuilder.customDamage and slot2 > 0 and slot2 or SkillEditorStepBuilder.defaultDamage

	function slot1.sureCallback(slot0)
		GameFacade.closeInputBox()

		if tonumber(slot0) and slot1 > 0 then
			GameFacade.showToast(ToastEnum.IconId, "伤害调整为 " .. slot0)

			SkillEditorStepBuilder.customDamage = slot1
		elseif string.nilorempty(slot0) then
			SkillEditorStepBuilder.customDamage = nil
		end
	end

	GameFacade.openInputBox(slot1)
end

function slot0._onClickOutline(slot0)
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnClickOutline)
end

function slot0._onClickPlayCardCameraAni(slot0, slot1)
	slot0._playCardCameraAniPlaying = not slot0._playCardCameraAniPlaying
	slot1.text = slot0._playCardCameraAniPlaying and "关闭出牌镜头" or "开启出牌镜头"

	FightController.instance:dispatchEvent(FightEvent.SkillEditorPlayCardCameraAni, slot0._playCardCameraAniPlaying)
end

function slot0._onClickSuZhenSwitch(slot0)
	if FightModel.instance:getMagicCircleInfo() and FightHelper.getEntity(FightEntityScene.MySideId) and lua_magic_circle.configDict[slot1.magicCircleId] then
		slot2.effect:removeEffectByEffectName(slot3.loopEffect)
	end
end

function slot0.addToolBtn(slot0, slot1, slot2, slot3)
	slot4 = gohelper.cloneInPlace(slot0._btnModel.gameObject, slot1)

	gohelper.setActive(slot4, true)

	slot5 = gohelper.getClick(slot4)
	slot6 = gohelper.findChildText(slot4, "Text")

	slot5:AddClickListener(slot2, slot3 or slot0, slot6)

	slot6.text = slot1
	slot0._btns = slot0._btns or {}

	table.insert(slot0._btns, slot5)

	return slot4
end

function slot0.addToolViewObj(slot0, slot1)
	return gohelper.cloneInPlace(slot0._gotoolviewmodel, slot1)
end

function slot0.onRefreshViewParam(slot0)
end

function slot0._onBtnTools(slot0)
	slot0._listState = not slot0._listState

	gohelper.setActive(slot0._toolsBtnList, slot0._listState)

	slot0._btnText.text = slot0._listState and "close" or "tools"

	for slot5 = 0, slot0._gotoolroot.transform.childCount - 1 do
		gohelper.setActive(slot0._gotoolroot.transform:GetChild(slot5).gameObject, false)
	end
end

function slot0.hideToolsBtnList(slot0)
	gohelper.setActive(slot0._toolsBtnList, false)
end

function slot0.onOpen(slot0)
	slot0._listState = true

	slot0:_onBtnTools()
	slot0:openSubView(SkillEditorToolsChangeVariant, slot0.viewGO)
	slot0:openSubView(SkillEditorToolsChangeQuality, slot0.viewGO)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
