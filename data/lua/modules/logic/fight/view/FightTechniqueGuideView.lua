module("modules.logic.fight.view.FightTechniqueGuideView", package.seeall)

slot0 = class("FightTechniqueGuideView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotargetframe = gohelper.findChild(slot0.viewGO, "#go_targetframe")
	slot0._goguidContent = gohelper.findChild(slot0.viewGO, "#go_guidContent")
	slot0._goguideitem = gohelper.findChild(slot0.viewGO, "#go_guidContent/#go_guideitem")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
	slot0:refresh()
end

function slot0.onOpen(slot0)
	slot0:refresh()
end

function slot0.refresh(slot0)
	TaskDispatcher.cancelTask(FightWorkFocusMonster.showCardPart, FightWorkFocusMonster)

	slot0._entityMO = slot0.viewParam.entity
	slot0._config = slot0.viewParam.config
	slot0._is_enter_type = slot0._config.invokeType == FightWorkFocusMonster.invokeType.Enter

	if slot0._entityMO then
		FightWorkFocusMonster.focusCamera(slot0._entityMO.id)
		FightController.instance:dispatchEvent(FightEvent.OnCameraFocusChanged, true)
	end

	slot0._show_des = string.split(slot0._config.des, "|")
	slot0._show_icon = string.split(slot0._config.icon, "|")
	slot0._isActivityVersion = string.split(slot0._config.isActivityVersion, "|")

	gohelper.CreateObjList(slot0, slot0._onItemShow, slot0._show_des, slot0._goguidContent, slot0._goguideitem)
	FightHelper.setMonsterGuideFocusState(slot0._config)
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	slot4 = slot1.transform
	slot7 = slot4:Find("go_career").gameObject
	slot4:Find("img_desc/txt_desc"):GetComponent(gohelper.Type_TextMesh).text = string.gsub(string.gsub(slot0._show_des[slot3], "%【", string.format("<color=%s>", "#F87D42")), "%】", "</color>")

	gohelper.findChildSingleImage(slot1, "simage_guideicon"):LoadImage(ResUrl.getFightTechniqueGuide(slot0._show_icon[slot3], slot0._isActivityVersion[slot3] == "1") or "")

	if not slot0._images then
		slot0._images = {}
	end

	table.insert(slot0._images, slot5)

	slot9 = gohelper.findChildImage(slot7, "image_bg")
	slot10 = nil

	if slot0._entityMO and slot0._entityMO.modelId or slot0.viewParam.modelId then
		slot10 = lua_monster.configDict[slot11] and slot12.career
	end

	slot12 = nil

	if slot10 and slot10 ~= 5 and slot10 ~= 6 then
		slot12 = FightConfig.instance:restrainedBy(slot10)

		SLFramework.UGUI.GuiHelper.SetColor(slot9, ({
			"#473115",
			"#192c40",
			"#243829",
			"#4d2525",
			"#462b48",
			"#564d26"
		})[slot12])
		UISpriteSetMgr.instance:setCommonSprite(gohelper.findChildImage(slot7, "image_career"), "lssx_" .. slot12)
	end

	gohelper.setActive(slot7, slot12 and slot3 == 1)
end

function slot0.onClose(slot0)
	FightWorkFocusMonster.cancelFocusCamera()
end

function slot0.onDestroyView(slot0)
	if slot0._images then
		for slot4, slot5 in ipairs(slot0._images) do
			slot5:UnLoadImage()
		end
	end

	slot0._images = nil
end

return slot0
