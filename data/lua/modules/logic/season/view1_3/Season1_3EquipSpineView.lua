module("modules.logic.season.view1_3.Season1_3EquipSpineView", package.seeall)

slot0 = class("Season1_3EquipSpineView", BaseView)

function slot0.onInitView(slot0)
	slot0._gospine = gohelper.findChild(slot0.viewGO, "left/hero/#go_herocontainer/dynamiccontainer/#go_spine")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._uiSpine = GuiModelAgent.Create(slot0._gospine, true)

	slot0:createSpine()
end

function slot0.onDestroyView(slot0)
	if slot0._uiSpine then
		slot0._uiSpine:onDestroy()

		slot0._uiSpine = nil
	end
end

function slot0.onOpen(slot0)
	slot0:refreshHeroSkin()
end

function slot0.onClose(slot0)
	if slot0._uiSpine then
		slot0._uiSpine:setModelVisible(false)
	end
end

function slot0.createSpine(slot0, slot1)
	if slot1 then
		slot0._uiSpine:useRT()

		slot2 = ViewMgr.instance:getUIRoot()

		slot0._uiSpine:setImgSize(slot2.transform.sizeDelta.x * 1.25, slot2.transform.sizeDelta.y * 1.25)
		slot0._uiSpine:setResPath(slot1, slot0.onSpineLoaded, slot0)

		slot3, slot4 = SkinConfig.instance:getSkinOffset(slot1.characterGetViewOffset)

		if slot4 then
			slot5, _ = SkinConfig.instance:getSkinOffset(slot1.characterViewOffset)
			slot3 = SkinConfig.instance:getAfterRelativeOffset(505, slot5)
		end

		logNormal(string.format("offset = %s, %s, scale = %s", tonumber(slot3[1]), tonumber(slot3[2]), tonumber(slot3[3])))
		recthelper.setAnchor(slot0._gospine.transform, tonumber(slot3[1]), tonumber(slot3[2]))
		transformhelper.setLocalScale(slot0._gospine.transform, tonumber(slot3[3]), tonumber(slot3[3]), tonumber(slot3[3]))
	end
end

function slot0.refreshHeroSkin(slot0)
	if not Activity104EquipItemListModel.instance:getPosHeroUid(Activity104EquipItemListModel.instance.curPos) or slot2 == Activity104EquipItemListModel.EmptyUid then
		gohelper.setActive(slot0._gospine, false)

		return nil
	end

	if not (HeroModel.instance:getById(tostring(slot2)) or HeroGroupTrialModel.instance:getById(slot2)) then
		logError(string.format("pos heroId [%s] can't find MO", tostring(slot2)))
		gohelper.setActive(slot0._gospine, false)

		return nil
	end

	slot4 = false

	if SkinConfig.instance:getSkinCo(slot3.skin) then
		gohelper.setActive(slot0._gospine, true)
		slot0:createSpine(slot6)
	else
		logError("skin config nil ! skin Id = " .. tostring(slot5))
	end
end

function slot0.onSpineLoaded(slot0)
	slot0._spineLoaded = true

	slot0._uiSpine:setUIMask(true)
end

return slot0
