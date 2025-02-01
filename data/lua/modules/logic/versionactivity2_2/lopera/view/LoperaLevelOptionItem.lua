module("modules.logic.versionactivity2_2.lopera.view.LoperaLevelOptionItem", package.seeall)

slot0 = class("LoperaLevelOptionItem", ListScrollCellExtend)
slot1 = VersionActivity2_2Enum.ActivityId.Lopera

function slot0.onInitView(slot0)
	slot0._optionText = gohelper.findChildText(slot0.viewGO, "#txt_Choice")
	slot0._optionEffectText = gohelper.findChildText(slot0.viewGO, "#txt_Choice/#txt_effect")
	slot0._btn = gohelper.findChildButtonWithAudio(slot0.viewGO, "image_ChoiceBG")
	slot0._goProp = gohelper.findChild(slot0.viewGO, "#image_Prop")
	slot0._imgPropIcon = gohelper.findChildImage(slot0.viewGO, "#image_Prop")
	slot0._goPowerIcon = gohelper.findChild(slot0.viewGO, "image_Power")
	slot0._goOption = gohelper.findChild(slot0.viewGO, "#txt_Choice")
	slot0._goEffectOption = gohelper.findChild(slot0.viewGO, "go_optionWithEffect")
	slot0._txtEffectOption = gohelper.findChildText(slot0.viewGO, "go_optionWithEffect/#txt_option")
	slot0._txtEffect = gohelper.findChildText(slot0.viewGO, "go_optionWithEffect/#txt_effect")
	slot0._costText = gohelper.findChildText(slot0.viewGO, "#txt_PowerNum")
	slot0._goCostNum = gohelper.findChild(slot0.viewGO, "#txt_PowerNum")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btn:AddClickListener(slot0._clickOption, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btn:RemoveClickListener()
end

function slot0._clickOption(slot0)
	if not string.nilorempty(slot0._mo.costItems) then
		slot1 = string.split(slot0._mo.costItems, "|")
		slot2 = string.splitToNumber(slot1[1], "#")[1]

		if Activity168Model.instance:getItemCount(slot2) < string.splitToNumber(slot1[1], "#")[2] then
			ToastController.instance:showToastWithString(formatLuaLang("store_currency_limit", Activity168Config.instance:getComposeTypeCfg(uv0, Activity168Config.instance:getGameItemCfg(uv0, slot2).compostType).name .. "-" .. slot5.name))

			return
		end
	end

	LoperaController.instance:selectOption(slot0._mo.optionId)
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
	slot0:addEventCb(LoperaController.instance, LoperaEvent.ComposeDone, slot0.refreshUI, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0:removeEventCb(LoperaController.instance, LoperaEvent.ComposeDone, slot0.refreshUI, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	if not slot0._mo then
		return
	end

	gohelper.setActive(slot0._goProp, false)
	gohelper.setActive(slot0._goPowerIcon, false)
	gohelper.setActive(slot0._goCostNum, false)
	gohelper.setActive(slot0._goEffectOption, false)
	gohelper.setActive(slot0._goOption, false)
	gohelper.setActive(slot0._txtEffect.gameObject, true)
	gohelper.setActive(slot0._optionEffectText.gameObject, false)

	slot0._btn.enabled = true
	slot1 = Activity168Config.instance:getOptionEffectCfg(slot0._mo.effectId)

	if not string.nilorempty(slot0._mo.costItems) then
		gohelper.setActive(slot0._goProp, true)
		gohelper.setActive(slot0._goCostNum, true)

		slot2 = string.split(slot0._mo.costItems, "|")
		slot3 = string.splitToNumber(slot2[1], "#")[1]
		slot4 = string.splitToNumber(slot2[1], "#")[2]
		slot6 = Activity168Model.instance:getItemCount(slot3)
		slot0._optionText.text = slot0._mo.name

		gohelper.setActive(slot0._optionEffectText.gameObject, true)

		slot0._optionEffectText.text = LoperaController.instance:checkOptionChoosed(slot0._mo.optionId) and slot1 and slot1.desc or ""
		gohelper.findChildText(slot0._goProp, "#txt_PropNum").text = slot6
		slot0._costText.text = "-" .. slot4
		slot9 = slot6 < slot4

		ZProj.UGUIHelper.SetGrayscale(slot0._btn.gameObject, slot9)

		slot0._btn.enabled = not slot9

		UISpriteSetMgr.instance:setLoperaItemSprite(slot0._imgPropIcon, Activity168Config.instance:getGameItemCfg(VersionActivity2_2Enum.ActivityId.Lopera, slot3).icon, false)
		gohelper.setActive(slot0._goOption, true)
	elseif slot1 then
		gohelper.setActive(slot0._goEffectOption, true)

		slot0._txtEffectOption.text = slot0._mo.name
		slot2 = LoperaController.instance:checkOptionChoosed(slot0._mo.optionId)

		gohelper.setActive(slot0._txtEffect.gameObject, slot2)

		if slot2 then
			slot0._txtEffect.text = slot1.desc
		end

		ZProj.UGUIHelper.SetGrayscale(slot0._btn.gameObject, false)
	else
		gohelper.setActive(slot0._goEffectOption, true)

		slot0._txtEffectOption.text = slot0._mo.name
		slot2 = LoperaController.instance:checkOptionChoosed(slot0._mo.optionId)

		gohelper.setActive(slot0._txtEffect.gameObject, slot2)

		if slot2 then
			slot0._txtEffect.text = luaLang("lopera_event_no_effect_buff")
		end

		ZProj.UGUIHelper.SetGrayscale(slot0._btn.gameObject, false)
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
