module("modules.logic.fight.view.FightTechniqueTipsView", package.seeall)

slot0 = class("FightTechniqueTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0._goclose = gohelper.findChildClick(slot0.viewGO, "#go_close")
	slot0._gocenter = gohelper.findChild(slot0.viewGO, "#go_center")
	slot0._txttemp = gohelper.findChildText(slot0.viewGO, "#txt_temp")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_center/#simage_icon")
	slot0._mask = gohelper.findChildClickWithAudio(slot0.viewGO, "mask")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._goclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._mask:AddClickListener(slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._goclose:RemoveClickListener()
	slot0._mask:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshView()
end

function slot0.onOpen(slot0)
	slot0:_refreshView()
end

function slot0._refreshView(slot0)
	if slot0.viewParam.isGMShow then
		slot0.config = slot0.viewParam.config
	else
		slot0.config = slot0.viewParam

		FightViewTechniqueModel.instance:readTechnique(slot0.config.id)
	end

	slot0._simageicon:LoadImage(ResUrl.getTechniqueLangIcon(slot0.config.picture2 or ""))

	slot1 = FightStrUtil.instance:getSplitCache(slot0.config.content1, "|")

	for slot5, slot6 in pairs(lua_fight_technique.configDict) do
		if gohelper.findChild(slot0.viewGO, "#go_center/content/" .. slot6.id) then
			gohelper.setActive(slot7, slot6.id == slot0.config.id)

			if slot0.config.id == slot6.id then
				for slot11, slot12 in ipairs(slot1) do
					slot17 = "<color=%s>"

					for slot17 = 0, slot7:GetComponentsInChildren(gohelper.Type_TextMesh).Length - 1 do
						if slot13[slot17].gameObject.name == "txt_" .. slot11 then
							slot13[slot17].text = string.gsub(string.gsub(slot12, "%{", string.format(slot17, "#ff906a")), "%}", "</color>")
						end
					end
				end
			end
		end
	end

	FightAudioMgr.instance:obscureBgm(true)
end

function slot0.onClose(slot0)
	FightAudioMgr.instance:obscureBgm(false)
end

function slot0.onDestroyView(slot0)
	slot0._simageicon:UnLoadImage()
end

return slot0
