module("modules.logic.rouge.view.RougeTalentTreeOverview", package.seeall)

slot0 = class("RougeTalentTreeOverview", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_desc")
	slot0._goattribute = gohelper.findChild(slot0.viewGO, "#scroll_desc/Viewport/Content/base/#go_attribute/attribute")
	slot0._gotalentitem = gohelper.findChild(slot0.viewGO, "#scroll_desc/Viewport/Content/talent/#go_talentitem")
	slot0._godetails = gohelper.findChild(slot0.viewGO, "#scroll_desc/Viewport/Content/talent/#go_talentitem/#go_details")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_empty")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#go_arrow")
	slot0._attributeItemList = {}
	slot0._talentItemList = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
	for slot4, slot5 in pairs(slot0._talentItemList) do
		if slot5 and slot5.btn then
			slot5.btn:RemoveClickListener()
		end
	end
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._season = RougeOutsideModel.instance:season()

	AudioMgr.instance:trigger(AudioEnum.UI.OpenTalentOverView)

	slot0._attributeMo, slot0._showMo = RougeTalentModel.instance:calculateTalent()

	if not slot0._showMo and not slot0._attributeMo then
		gohelper.setActive(slot0._goempty, true)
		gohelper.setActive(slot0._scrolldesc.gameObject, false)

		return
	else
		gohelper.setActive(slot0._goempty, false)
		gohelper.setActive(slot0._scrolldesc.gameObject, true)
	end

	if next(slot0._showMo) then
		for slot4, slot5 in pairs(slot0._showMo) do
			if not slot0._talentItemList[slot4] then
				slot6 = slot0:getUserDataTb_()
				slot7 = gohelper.cloneInPlace(slot0._gotalentitem, slot4)
				slot6.go = slot7
				slot6.name = gohelper.findChildText(slot7, "info/img_titleline/#txt_talenname")
				slot6.icon = gohelper.findChildImage(slot7, "info/img_titleline/#image_icon")
				slot6.btn = gohelper.findChildButton(slot7, "info/#btn_arrow")
				slot6.gobtnopen = gohelper.findChild(slot7, "info/#btn_arrow/open")
				slot6.gobtnclose = gohelper.findChild(slot7, "info/#btn_arrow/close")
				slot6.isopen = false
				slot6.details = {}

				for slot16, slot17 in pairs(slot5) do
					slot18 = slot0:getUserDataTb_()
					slot19 = gohelper.clone(slot0._godetails, slot7, slot17)
					slot18.go = slot19

					gohelper.setActive(slot19, false)

					slot18.gotalentdesc = gohelper.findChild(slot19, "#txt_unlockdec")
					slot18.txttalentdesc = gohelper.findChildText(slot19, "#txt_unlockdec")
					slot18.goUnlockdesc = gohelper.findChild(slot19, "#txt_talentdec")
					slot18.txtUnlockdesc = gohelper.findChildText(slot19, "#txt_talentdec")
					slot21 = RougeTalentConfig.instance:getBranchConfigByID(slot0._season, slot17).isOrigin == 1

					gohelper.setActive(slot18.gotalentdesc, not slot21)
					gohelper.setActive(slot18.goUnlockdesc, slot21)

					slot18.txttalentdesc.text = slot20.desc
					slot18.txtUnlockdesc.text = slot20.desc
					slot6.details[slot17] = slot18
				end

				gohelper.setActive(slot11, false)
				gohelper.setActive(slot12, true)
				slot6.btn:AddClickListener(function ()
					uv0.isopen = not uv0.isopen

					if next(uv0.details) then
						for slot3, slot4 in pairs(uv0.details) do
							gohelper.setActive(slot4.go, uv0.isopen)
						end
					end

					gohelper.setActive(uv1, uv0.isopen)
					gohelper.setActive(uv2, not uv0.isopen)
					AudioMgr.instance:trigger(AudioEnum.UI.ClickOverBranch)
				end, slot0)
				gohelper.setActive(slot7, true)

				slot0._talentItemList[slot4] = slot6
			end

			slot7 = RougeTalentConfig.instance:getConfigByTalent(slot0._season, slot4)
			slot6.name.text = slot7.name

			UISpriteSetMgr.instance:setRougeSprite(slot6.icon, slot7.icon)
		end
	end

	if #slot0._attributeMo > 0 then
		for slot4, slot5 in ipairs(slot0._attributeMo) do
			if not slot0._attributeItemList[slot4] then
				slot6 = slot0:getUserDataTb_()
				slot7 = gohelper.cloneInPlace(slot0._goattribute, slot4)
				slot6.go = slot7
				slot6.rate = gohelper.findChildText(slot7, "txt_attribute")
				slot6.name = gohelper.findChildText(slot7, "name")
				slot6.icon = gohelper.findChildImage(slot7, "icon")

				gohelper.setActive(slot7, true)
				gohelper.setActive(gohelper.findChild(slot7, "bg"), math.ceil(slot4 / 2) % 2 ~= 0)
				table.insert(slot0._attributeItemList, slot6)
			end

			if slot5.ismul then
				slot6.rate.text = slot5.isattribute and "+" .. slot5.rate * 0.1 .. "%" or "+" .. slot5.rate .. "%"
			else
				slot6.rate.text = "+" .. slot5.rate
			end

			if slot5.isattribute then
				if slot5.id == 215 or slot5.id == 216 then
					UISpriteSetMgr.instance:setCommonSprite(slot6.icon, slot5.icon)
				end

				UISpriteSetMgr.instance:setCommonSprite(slot6.icon, slot5.icon)
			else
				UISpriteSetMgr.instance:setRougeSprite(slot6.icon, slot5.icon)
			end

			slot6.name.text = slot5.name
		end
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
