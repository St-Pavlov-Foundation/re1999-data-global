module("modules.logic.tips.view.MaterialTipView", package.seeall)

slot0 = class("MaterialTipView", BaseView)

function slot0.onInitView(slot0)
	if GMController.instance:getGMNode("materialtipview", slot0.viewGO) then
		slot0._gogm = gohelper.findChild(slot1, "#go_gm")
		slot0._txtmattip = gohelper.findChildText(slot1, "#go_gm/bg/#txt_mattip")
		slot0._btnone = gohelper.findChildButtonWithAudio(slot1, "#go_gm/#btn_one")
		slot0._btnten = gohelper.findChildButtonWithAudio(slot1, "#go_gm/#btn_ten")
		slot0._btnhundred = gohelper.findChildButtonWithAudio(slot1, "#go_gm/#btn_hundred")
		slot0._btnthousand = gohelper.findChildButtonWithAudio(slot1, "#go_gm/#btn_thousand")
		slot0._btntenthousand = gohelper.findChildButtonWithAudio(slot1, "#go_gm/#btn_tenthousand")
		slot0._btntenmillion = gohelper.findChildButtonWithAudio(slot1, "#go_gm/#btn_tenmillion")
		slot0._btninput = gohelper.findChildButtonWithAudio(slot1, "#go_gm/#btn_input")
	end

	slot0._simageblur = gohelper.findChildSingleImage(slot0.viewGO, "#simage_blur")
	slot0._simagepropicon = gohelper.findChildSingleImage(slot0.viewGO, "iconbg/#simage_propicon")
	slot0._goequipicon = gohelper.findChild(slot0.viewGO, "iconbg/#go_equipicon")
	slot0._simageequipicon = gohelper.findChildSingleImage(slot0.viewGO, "iconbg/#go_equipicon/#simage_equipicon")
	slot0._gohadnumber = gohelper.findChild(slot0.viewGO, "iconbg/#go_hadnumber")
	slot0._txthadnumber = gohelper.findChildText(slot0.viewGO, "iconbg/#go_hadnumber/#txt_hadnumber")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "iconbg/#btn_detail")
	slot0._btnplayerbg = gohelper.findChildButtonWithAudio(slot0.viewGO, "iconbg/#btn_playerbg")
	slot0._txtpropname = gohelper.findChildText(slot0.viewGO, "#txt_propname")
	slot0._txtproptip = gohelper.findChildText(slot0.viewGO, "#go_expiretime/#txt_proptip")
	slot0._txtexpire = gohelper.findChildText(slot0.viewGO, "#go_expiretime/#txt_expire")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_desc")
	slot0._gojumptxt = gohelper.findChild(slot0.viewGO, "#scroll_desc/#go_jumptxt")
	slot0._gojumpItem = gohelper.findChild(slot0.viewGO, "#scroll_desc/#go_jumpItem")
	slot0._gosource = gohelper.findChild(slot0.viewGO, "#scroll_desc/viewport/content/#go_source")
	slot0._txtsource = gohelper.findChildText(slot0.viewGO, "#scroll_desc/viewport/content/#go_source/#txt_source")
	slot0._gouse = gohelper.findChild(slot0.viewGO, "#go_use")
	slot0._gouseDetail = gohelper.findChild(slot0.viewGO, "#go_use/#go_usedetail")
	slot0._inputvalue = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_use/#go_usedetail/valuebg/#input_value")
	slot0._btnmin = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_use/#go_usedetail/#btn_min")
	slot0._btnsub = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_use/#go_usedetail/#btn_sub")
	slot0._btnadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_use/#go_usedetail/#btn_add")
	slot0._btnmax = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_use/#go_usedetail/#btn_max")
	slot0._btnuse = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_use/#btn_use")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "bg/#btn_close")
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg2")
	slot0._goinclude = gohelper.findChild(slot0.viewGO, "#go_include")
	slot0._goplayericon = gohelper.findChild(slot0.viewGO, "iconbg/#go_playericon")
	slot0._simageheadicon = gohelper.findChildSingleImage(slot0.viewGO, "iconbg/#go_playericon/#simage_headicon")
	slot0._goupgrade = gohelper.findChild(slot0.viewGO, "iconbg/#go_upgrade")
	slot0._goframe = gohelper.findChild(slot0.viewGO, "iconbg/#go_playericon/#go_frame")
	slot0._goframenode = gohelper.findChild(slot0.viewGO, "iconbg/#go_playericon/#go_framenode")
	slot0._goSummonsimulationtips = gohelper.findChild(slot0.viewGO, "#go_summonpicktips")
	slot0._btnsummonsimulation = gohelper.findChildButton(slot0.viewGO, "#btn_summonSiumlationTips")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end

	slot0._loader = MultiAbLoader.New()
end

function slot0.addEvents(slot0)
	if slot0._btnone then
		slot0._btnone:AddClickListener(slot0._btnoneOnClick, slot0)
	end

	if slot0._btnten then
		slot0._btnten:AddClickListener(slot0._btntenOnClick, slot0)
	end

	if slot0._btnhundred then
		slot0._btnhundred:AddClickListener(slot0._btnhundredOnClick, slot0)
	end

	if slot0._btnthousand then
		slot0._btnthousand:AddClickListener(slot0._btnthousandOnClick, slot0)
	end

	if slot0._btntenthousand then
		slot0._btntenthousand:AddClickListener(slot0._btntenthousandOnClick, slot0)
	end

	if slot0._btntenmillion then
		slot0._btntenmillion:AddClickListener(slot0._btntenmillionOnClick, slot0)
	end

	if slot0._btninput then
		slot0._btninput:AddClickListener(slot0._btninputOnClick, slot0)
	end

	if slot0._btnplayerbg then
		slot0._btnplayerbg:AddClickListener(slot0._btnplayerbgOnClick, slot0)
	end

	if slot0._btnsummonsimulation then
		slot0._btnsummonsimulation:AddClickListener(slot0._btnsummonsimulationOnClick, slot0)
	end

	slot0._btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
	slot0._btnmin:AddClickListener(slot0._btnminOnClick, slot0)
	slot0._btnsub:AddClickListener(slot0._btnsubOnClick, slot0)
	slot0._btnadd:AddClickListener(slot0._btnaddOnClick, slot0)
	slot0._btnmax:AddClickListener(slot0._btnmaxOnClick, slot0)
	slot0._btnuse:AddClickListener(slot0._btnuseOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._inputvalue:AddOnEndEdit(slot0._onEndEdit, slot0)
end

function slot0.removeEvents(slot0)
	if slot0._btnone then
		slot0._btnone:RemoveClickListener()
	end

	if slot0._btnten then
		slot0._btnten:RemoveClickListener()
	end

	if slot0._btnhundred then
		slot0._btnhundred:RemoveClickListener()
	end

	if slot0._btnthousand then
		slot0._btnthousand:RemoveClickListener()
	end

	if slot0._btntenthousand then
		slot0._btntenthousand:RemoveClickListener()
	end

	if slot0._btntenmillion then
		slot0._btntenmillion:RemoveClickListener()
	end

	if slot0._btninput then
		slot0._btninput:RemoveClickListener()
	end

	if slot0._btnplayerbg then
		slot0._btnplayerbg:RemoveClickListener()
	end

	if slot0._btnsummonsimulation then
		slot0._btnsummonsimulation:RemoveClickListener()
	end

	slot0._btndetail:RemoveClickListener()
	slot0._btnmin:RemoveClickListener()
	slot0._btnsub:RemoveClickListener()
	slot0._btnadd:RemoveClickListener()
	slot0._btnmax:RemoveClickListener()
	slot0._btnuse:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._inputvalue:RemoveOnEndEdit()
end

slot1 = {
	[MaterialEnum.MaterialType.Item] = {
		[BpEnum.ScoreItemId] = true
	},
	[MaterialEnum.MaterialType.Currency] = {
		[CurrencyEnum.CurrencyType.V1a6CachotCoin] = true,
		[CurrencyEnum.CurrencyType.V1a6CachotCurrency] = true
	}
}

function slot0._btndetailOnClick(slot0)
	if not slot0._canJump then
		GameFacade.showToast(ToastEnum.MaterialTipJump)

		return
	end

	JumpController.instance:jumpByParamWithCondition(string.format("51#%d", slot0.viewParam.id), slot0._onJumpFinish, slot0)
end

function slot0._btnplayerbgOnClick(slot0)
	ViewMgr.instance:openView(ViewName.PlayerChangeBgView, {
		itemMo = slot0.viewParam
	})
end

function slot0._btnsummonsimulationOnClick(slot0)
	if not slot0._config or not slot0._config.activityId then
		return
	end

	SummonSimulationPickController.instance:openSummonTips(slot0._config.activityId)
end

function slot0._onEndEdit(slot0, slot1)
	slot0._valueChanged = false
	slot0._value = tonumber(slot1)

	if slot0:_getMaxValue() < slot0._value then
		slot0._value = slot0:_getMaxValue()

		slot0._inputvalue:SetText(tostring(slot0._value))

		slot0._valueChanged = true

		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end

	if slot0._value < 1 then
		slot0._value = 1

		slot0._inputvalue:SetText(tostring(slot0._value))

		slot0._valueChanged = true

		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btninputOnClick(slot0)
	slot1 = CommonInputMO.New()
	slot1.title = "请输入增加道具数量！"
	slot1.defaultInput = "Enter Item Num"

	function slot1.sureCallback(slot0)
		GameFacade.closeInputBox()

		if tonumber(slot0) and slot1 > 0 then
			uv0:sendGMRequest(slot1)
		end
	end

	GameFacade.openInputBox(slot1)
end

function slot0._btntenmillionOnClick(slot0)
	slot0:sendGMRequest(10000000)
end

function slot0._btnoneOnClick(slot0)
	slot0:sendGMRequest(1)
end

function slot0._btntenOnClick(slot0)
	slot0:sendGMRequest(10)
end

function slot0._btnhundredOnClick(slot0)
	slot0:sendGMRequest(100)
end

function slot0._btnthousandOnClick(slot0)
	slot0:sendGMRequest(1000)
end

function slot0._btntenthousandOnClick(slot0)
	slot0:sendGMRequest(10000)
end

function slot0.sendGMRequest(slot0, slot1)
	GameFacade.showToast(ToastEnum.GMTool5, slot0.viewParam.id)

	if slot0.viewParam.type == MaterialEnum.MaterialType.Item and slot0.viewParam.id == 510001 then
		GMRpc.instance:sendGMRequest(string.format("add heroStoryTicket %d", slot1))
	else
		GMRpc.instance:sendGMRequest(string.format("add material %d#%d#%d", slot0.viewParam.type, slot0.viewParam.id, slot1))
	end
end

function slot0._editableInitView(slot0)
	if slot0._gogm then
		gohelper.setActive(slot0._gogm, GMController.instance:isOpenGM())
	end

	slot0._txtdesc = SLFramework.GameObjectHelper.FindChildComponent(slot0.viewGO, "#scroll_desc/viewport/content/desc", typeof(TMPro.TextMeshProUGUI))
	slot0._txtusedesc = SLFramework.GameObjectHelper.FindChildComponent(slot0.viewGO, "#scroll_desc/viewport/content/usedesc", typeof(TMPro.TextMeshProUGUI))

	gohelper.setActive(slot0._gojumpItem, false)
	gohelper.setActive(slot0._gojumptxt, false)

	slot0.jumpItemGos = {}
	slot0._boxItemGos = {}
	slot0._iconItemList = {}
	slot0._value = 1
	slot0._goincludeContent = gohelper.findChild(slot0._goinclude, "#scroll_product/viewport/content")
	slot0._contentHorizontal = slot0._goincludeContent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))

	slot0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))

	slot0._txtsource.text = luaLang("materialview_source")
end

function slot0._cloneJumpItem(slot0)
	slot1 = gohelper.findChild(slot0.viewGO, "#scroll_desc/viewport/content")
	slot0._scrolldesc.verticalNormalizedPosition = 1
	slot2 = {}
	slot3 = ViewMgr.instance:isOpen(ViewName.GiftMultipleChoiceView)

	if ItemModel.instance:getOptionalGiftBySubTypeAndRare(slot0._config.subType, slot0._config.rare, slot0._config.id) then
		for slot8, slot9 in pairs(slot4) do
			table.insert(slot2, {
				sourceId = 1,
				sourceParam = slot9.id
			})
		end
	end

	if not string.nilorempty(slot0._config.boxOpen) and not slot3 then
		for slot9, slot10 in ipairs(string.split(slot0._config.boxOpen, "|")) do
			slot11 = string.splitToNumber(slot10, "#")

			table.insert(slot2, {
				sourceId = slot11[1],
				sourceParam = slot11[2]
			})
		end
	end

	if slot2 then
		for slot8, slot9 in ipairs(slot2) do
			if ItemModel.instance:getItemCount(slot9.sourceParam) > 0 then
				if not slot0._boxItemGos[slot8] then
					slot11 = gohelper.clone(slot0._gojumpItem, slot1, "boxitem" .. slot8)
					slot12 = slot0:getUserDataTb_()
					slot12.go = slot11
					slot12.layout = gohelper.findChild(slot11, "layout"):GetComponent(typeof(ZProj.LimitedScrollRect))
					slot12.originText = gohelper.findChildText(slot11, "layout/Viewport/Content/originText")
					slot12.indexText = gohelper.findChildText(slot11, "indexText")
					slot12.jumpBtn = gohelper.findChildButtonWithAudio(slot11, "jump/jumpBtn")
					slot12.hasjump = gohelper.findChild(slot11, "jump")
					slot12.jumpText = gohelper.findChildText(slot11, "jump/jumpBtn/jumpText")
					slot12.jumpHardTagGO = gohelper.findChild(slot11, "layout/Viewport/Content/hardtag")
					slot12.jumpBgGO = gohelper.findChild(slot11, "jump/bg")
					slot12.probalityBg = gohelper.findChild(slot11, "layout/Viewport/Content/bg")
					slot12.txtProbality = gohelper.findChildText(slot11, "layout/Viewport/Content/bg/probality")
					slot13 = slot2.episodeId and slot2.probability and MaterialEnum.JumpProbabilityDisplay[slot2.probability]
					slot12.txtProbality.text = slot13 and string.format("%s", luaLang(MaterialEnum.JumpProbabilityDisplay[slot2.probability])) or ""

					gohelper.setActive(slot12.probalityBg, slot13 and true or false)
					gohelper.setActive(slot12.jumpHardTagGO, false)

					slot12.jumpText.text = string.format(luaLang("p_materialtip_jump"), "")
					slot12.originText.text = string.format("<color=#3f485f><size=32>%s</size></color>", string.format(luaLang("material_storage"), ItemConfig.instance:getItemCo(tonumber(slot9.sourceParam)).name))
					slot12.indexText.text = ""

					table.insert(slot0._boxItemGos, slot12)

					slot12.layout.parentGameObject = slot0._scrolldesc.gameObject

					slot12.jumpBtn:AddClickListener(function (slot0)
						slot2 = ItemModel.instance:getItemCount(uv1.sourceParam)

						GiftModel.instance:reset()

						if uv0.viewParam.needQuantity then
							if uv0.viewParam.needQuantity < ItemModel.instance:getItemCount(uv0._config.id) or not uv0.viewParam.isConsume then
								uv0._value = 1
							else
								if slot2 > uv0.viewParam.needQuantity - slot1 then
									uv0._value = uv0.viewParam.needQuantity - slot1 == 0 and 1 or uv0.viewParam.needQuantity - slot1
								else
									uv0._value = slot2
								end

								if slot1 < uv0.viewParam.needQuantity then
									GiftModel.instance:setNeedGift(uv0.viewParam.id)
								end
							end
						else
							uv0._value = 1
						end

						MaterialTipController.instance:showMaterialInfo(uv1.sourceId, uv1.sourceParam, true)
					end, slot12)
				end

				gohelper.setActive(slot0._boxItemGos[slot8].go, true)
			elseif slot0._boxItemGos[slot8] then
				gohelper.setActive(slot0._boxItemGos[slot8].go, false)
			end
		end
	end

	slot6 = {}

	if not string.nilorempty(slot0._config.sources) then
		for slot11, slot12 in ipairs(string.split(slot5, "|")) do
			slot13 = string.splitToNumber(slot12, "#")
			slot14 = {
				sourceId = slot13[1],
				probability = slot13[2]
			}
			slot14.episodeId = JumpConfig.instance:getJumpEpisodeId(slot14.sourceId)

			if JumpConfig.instance:isOpenJumpId(slot14.sourceId) and (slot14.probability ~= MaterialEnum.JumpProbability.Normal or not DungeonModel.instance:hasPassLevel(slot14.episodeId)) then
				table.insert(slot6, slot14)
			end
		end
	end

	if DungeonConfig.instance:getMaterialSource(slot0.viewParam.type, slot0.viewParam.id) then
		for slot11, slot12 in ipairs(slot7) do
			slot13 = {
				sourceId = -1,
				probability = slot12.probability,
				episodeId = slot12.episodeId,
				jumpParam = string.format("4#%s", slot12.episodeId)
			}
			slot14 = false

			if slot12.episodeId and DungeonConfig.instance:getEpisodeCO(slot12.episodeId) then
				slot14 = ResSplitConfig.instance:isSaveChapter(slot15.chapterId)
			end

			slot13.isOpen = slot14

			table.insert(slot6, slot13)
		end
	end

	for slot11 = 1, #slot6 do
		if not slot0.jumpItemGos[slot11] then
			slot13 = gohelper.clone(slot0._gojumpItem, slot1, "item" .. slot11)
			slot12 = slot0:getUserDataTb_()
			slot12.go = slot13
			slot12.layout = gohelper.findChild(slot13, "layout"):GetComponent(typeof(ZProj.LimitedScrollRect))
			slot12.originText = gohelper.findChildText(slot13, "layout/Viewport/Content/originText")
			slot12.indexText = gohelper.findChildText(slot13, "indexText")
			slot12.jumpBtn = gohelper.findChildButtonWithAudio(slot13, "jump/jumpBtn")
			slot12.hasjump = gohelper.findChild(slot13, "jump")
			slot12.jumpText = gohelper.findChildText(slot13, "jump/jumpBtn/jumpText")
			slot12.jumpHardTagGO = gohelper.findChild(slot13, "layout/Viewport/Content/hardtag")
			slot12.jumpBgGO = gohelper.findChild(slot13, "jump/bg")
			slot12.probalityBg = gohelper.findChild(slot13, "layout/Viewport/Content/bg")
			slot12.txtProbality = gohelper.findChildText(slot13, "layout/Viewport/Content/bg/probality")

			table.insert(slot0.jumpItemGos, slot12)

			slot12.layout.parentGameObject = slot0._scrolldesc.gameObject

			slot12.jumpBtn:AddClickListener(function (slot0)
				if slot0.cantJumpTips then
					GameFacade.showToastWithTableParam(slot0.cantJumpTips, slot0.cantJumpParam)
				elseif slot0.canJump then
					if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.ForceJumpToMainView) then
						NavigateButtonsView.homeClick()

						return
					end

					if slot0.jumpParam then
						ViewMgr.instance:closeView(ViewName.RoomInitBuildingView)
						JumpController.instance:jumpTo(slot0.jumpParam, uv0._onJumpFinish, uv0, uv0.viewParam.recordFarmItem)
					else
						JumpController.instance:dispatchEvent(JumpEvent.JumpBtnClick, slot0.jumpId)
						GameFacade.jump(slot0.jumpId, uv0._onJumpFinish, uv0, uv0.viewParam.recordFarmItem)
						uv0:statJump(slot0.jumpId)
					end
				else
					GameFacade.showToast(ToastEnum.MaterialTipJump)
				end
			end, slot12)
		end

		slot13 = slot6[slot11]
		slot12.canJump = slot0._canJump
		slot12.jumpId = slot13.sourceId
		slot12.jumpParam = slot13.jumpParam
		slot14 = slot13.sourceId ~= -1 and JumpConfig.instance:getJumpConfig(slot13.sourceId)
		slot15 = ""
		slot16 = ""

		if slot13.sourceId == -1 then
			slot15, slot16 = JumpConfig.instance:getEpisodeNameAndIndex(slot13.episodeId)
		elseif string.nilorempty(slot14.param) then
			slot15 = slot14.name
		else
			slot15, slot16 = JumpConfig.instance:getJumpName(slot13.sourceId)
		end

		slot12.originText.text = slot15 or ""
		slot12.indexText.text = slot16 or ""
		slot17 = slot13.episodeId and slot13.probability and MaterialEnum.JumpProbabilityDisplay[slot13.probability]
		slot12.txtProbality.text = slot17 and string.format("%s", luaLang(MaterialEnum.JumpProbabilityDisplay[slot13.probability])) or ""
		slot12.jumpText.text = luaLang("p_materialtip_jump")

		gohelper.setActive(slot12.probalityBg, slot17 and true or false)

		slot18 = slot14 and slot14.param or slot13.jumpParam
		slot19 = nil
		slot20, slot21 = nil

		if not ((slot13.sourceId ~= -1 or slot13.isOpen) and (slot13.sourceId ~= JumpEnum.BPChargeView or (BpModel.instance:isEnd() or JumpController.instance:isJumpOpen(slot13.sourceId)) and false) and JumpController.instance:isJumpOpen(slot13.sourceId)) and slot13.sourceId ~= -1 then
			slot20, slot21 = OpenHelper.getToastIdAndParam(slot14.openId)
		else
			slot20, slot21 = JumpController.instance:cantJump(slot18)
		end

		if tonumber(string.split(slot18, "#")[1]) == JumpEnum.JumpView.RoomProductLineView and not slot20 then
			slot24, slot25, slot26 = nil
			slot27, slot20, slot25 = RoomProductionHelper.isChangeFormulaUnlock(slot0.viewParam.type, slot0.viewParam.id)

			if not slot27 then
				slot21 = slot25 and {
					slot25
				} or nil
			end
		end

		gohelper.setActive(slot12.hasjump, not (slot13.sourceId ~= -1 and JumpController.instance:isOnlyShowJump(slot13.sourceId)))
		ZProj.UGUIHelper.SetGrayscale(slot12.jumpText.gameObject, slot20 ~= nil)
		ZProj.UGUIHelper.SetGrayscale(slot12.jumpBgGO, slot20 ~= nil)

		slot12.cantJumpTips = slot20
		slot12.cantJumpParam = slot21

		gohelper.setActive(slot12.jumpHardTagGO, JumpConfig.instance:isJumpHardDungeon(slot13.episodeId))
		gohelper.setActive(slot12.go, true)
	end

	gohelper.setActive(slot0._gosource, #slot6 > 0 or #slot2 > 0)

	for slot11 = #slot2 + 1, #slot0._boxItemGos do
		gohelper.setActive(slot0._boxItemGos[slot11].go, false)
	end

	for slot11 = #slot6 + 1, #slot0.jumpItemGos do
		gohelper.setActive(slot0.jumpItemGos[slot11].go, false)
	end
end

function slot0._setJumpMaxIndexWidth(slot0, slot1)
	for slot6 = 1, slot1 do
		if slot0.jumpItemGos[slot6] and 0 < slot7.indexText.preferredWidth then
			slot2 = slot8
		end
	end

	for slot6 = 1, slot1 do
		if slot0.jumpItemGos[slot6] then
			slot8 = slot7.indexText.text

			recthelper.setAnchorX(slot7.originText.transform, slot2 > 0 and slot2 + 15 or -4)
		end
	end
end

function slot0._onJumpFinish(slot0)
	ViewMgr.instance:closeView(ViewName.MaterialPackageTipView)
	slot0:closeThis()

	if slot0.viewParam.jumpFinishCallback then
		slot0.viewParam.jumpFinishCallback(slot0.viewParam.jumpFinishCallbackObj, slot0.viewParam.jumpFinishCallbackParam)
	end
end

function slot0._btnuseOnClick(slot0)
	if slot0._valueChanged then
		slot0._valueChanged = false

		return
	end

	slot0._value = tonumber(slot0._inputvalue:GetText())

	if slot0:_getMaxValue() < slot0._value then
		slot0._value = slot0:_getMaxValue()

		slot0._inputvalue:SetText(tostring(slot0._value))
		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end

	if slot0._value < 1 then
		slot0._value = 1

		slot0._inputvalue:SetText(tostring(slot0._value))
		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end

	if slot0.viewParam.type == MaterialEnum.MaterialType.PowerPotion then
		CurrencyController.instance:openPowerView()

		return
	elseif slot0.viewParam.type == MaterialEnum.MaterialType.NewInsight then
		slot0:closeThis()
		GiftController.instance:openGiftInsightHeroChoiceView(slot0.viewParam)

		return
	end

	if slot0._config.subType == ItemEnum.SubType.SpecifiedGift then
		GiftController.instance:openGiftMultipleChoiceView({
			param = slot0.viewParam,
			quantity = slot0._value,
			subType = slot0._config.subType
		})
	elseif slot0._config.subType == ItemEnum.SubType.OptionalGift then
		GiftController.instance:openOptionalGiftMultipleChoiceView({
			param = slot0.viewParam,
			quantity = slot0._value,
			subType = slot0._config.subType
		})
	elseif slot0._config.subType == ItemEnum.SubType.OptionalHeroGift then
		if string.nilorempty(slot0._config.effect) then
			return
		end

		if slot0._config.id == ItemEnum.NewbiePackGiftId then
			CustomPickChoiceController.instance:openNewBiePickChoiceView(string.splitToNumber(slot0._config.effect, "#"), MaterialTipController.onUseOptionalHeroGift, MaterialTipController, {
				id = slot0._config.id,
				quantity = slot0._value,
				styleId = CustomPickChoiceEnum.style.OptionalHeroGift
			})
		else
			CustomPickChoiceController.instance:openCustomPickChoiceView(slot1, MaterialTipController.onUseOptionalHeroGift, MaterialTipController, slot3)
		end
	elseif slot0._config.subType == ItemEnum.SubType.SkinTicket then
		StoreController.instance:openStoreView(500)
	elseif slot0._config.subType == ItemEnum.SubType.RoomTicket then
		GameFacade.showMessageBox(MessageBoxIdDefine.GoToUseRoomTicket, MsgBoxEnum.BoxType.Yes_No, slot0._useRoomTicket, nil, , slot0, nil, )
	elseif slot0._config.subType == ItemEnum.SubType.SummonSimulationPick then
		slot0:_tryUseSummonSimulation(slot0._config.activityId)

		return
	else
		slot1 = {}

		table.insert(slot1, {
			materialId = slot0._config.id,
			quantity = slot0._value
		})
		ItemRpc.instance:sendUseItemRequest(slot1, 0)
	end

	slot0:closeThis()
end

function slot0._useRoomTicket(slot0)
	GameFacade.jump(JumpEnum.JumpId.RoomStore, slot0._onJumpFinish, slot0)
end

function slot0._tryUseSummonSimulation(slot0, slot1)
	SummonSimulationPickController.instance:registerCallback(SummonSimulationEvent.onGetSummonInfo, slot0._realUseSummonSimulation, slot0)
	SummonSimulationPickController.instance:getActivityInfo(slot1)
end

function slot0._realUseSummonSimulation(slot0, slot1)
	SummonSimulationPickController.instance:unregisterCallback(SummonSimulationEvent.onGetSummonInfo, slot0._realUseSummonSimulation, slot0)
	SummonSimulationPickController.instance:trySummonSimulation(slot1)
	slot0:closeThis()
end

function slot0._btnaddOnClick(slot0)
	if slot0._valueChanged then
		slot0._valueChanged = false

		return
	end

	slot0._value = tonumber(slot0._inputvalue:GetText())

	if slot0:_getMaxValue() <= slot0._value then
		slot0._value = slot0:_getMaxValue()

		slot0._inputvalue:SetText(tostring(slot0._value))
		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end

	slot0._value = slot0._value + 1

	slot0:_refreshValue()
end

function slot0._btnsubOnClick(slot0)
	if slot0._valueChanged then
		slot0._valueChanged = false

		return
	end

	slot0._value = tonumber(slot0._inputvalue:GetText())

	if slot0._value <= 1 then
		slot0._value = 1

		slot0._inputvalue:SetText(tostring(slot0._value))
		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end

	slot0._value = slot0._value - 1

	slot0:_refreshValue()
end

function slot0._btnmaxOnClick(slot0)
	slot0._value = slot0:_getMaxValue()

	slot0:_refreshValue()
end

function slot0._btnminOnClick(slot0)
	slot0._value = 1

	slot0:_refreshValue()
end

function slot0.onDestroyView(slot0)
end

function slot0._refreshValue(slot0)
	slot0._inputvalue:SetText(tostring(slot0._value))
end

function slot0._getMaxValue(slot0)
	if slot0._config.isStackable == 1 then
		slot1 = ItemModel.instance:getItemCount(slot0._config.id)

		if ItemConfig.instance:getItemUseCo(slot0._config.subType).useType == 2 then
			return 1
		elseif slot2.useType == 6 then
			return slot2.use_max < slot1 and slot2.use_max or slot1
		end
	end

	return 1
end

function slot0.onOpen(slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._refreshItemQuantity, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._refreshItemQuantity, slot0)
	slot0:addGmBtnAudio()
	slot0:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Tipsopen)
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshUI()
end

function slot0.addGmBtnAudio(slot0)
	if slot0._btnone then
		gohelper.addUIClickAudio(slot0._btnone.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if slot0._btnten then
		gohelper.addUIClickAudio(slot0._btnten.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if slot0._btnhundred then
		gohelper.addUIClickAudio(slot0._btnhundred.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if slot0._btnthousand then
		gohelper.addUIClickAudio(slot0._btnthousand.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if slot0._btntenthousand then
		gohelper.addUIClickAudio(slot0._btntenthousand.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if slot0._btntenmillion then
		gohelper.addUIClickAudio(slot0._btntenmillion.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if slot0._btninput then
		gohelper.addUIClickAudio(slot0._btninput.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end
end

function slot0._refreshUI(slot0)
	slot0._canJump = slot0.viewParam.canJump

	if slot0._txtmattip then
		slot0._txtmattip.text = tostring(slot0.viewParam.type) .. "#" .. tostring(slot0.viewParam.id)
	end

	slot0._config, slot0._icon = ItemModel.instance:getItemConfigAndIcon(slot0.viewParam.type, slot0.viewParam.id)

	if slot0.viewParam.type == MaterialEnum.MaterialType.Equip then
		slot0._icon = ResUrl.getEquipIcon(slot0._config.icon)
	elseif slot0._config.subType == ItemEnum.SubType.Portrait then
		slot0._icon = ResUrl.getPlayerHeadIcon(slot0._config.icon)
	end

	gohelper.setActive(slot0._simagepropicon.gameObject, false)

	if slot0:_isUseBtnShow() then
		gohelper.setActive(slot0._gouse, true)

		slot1 = true

		if slot0.viewParam.type == MaterialEnum.MaterialType.PowerPotion then
			slot1 = false
		elseif slot0._config.subType == ItemEnum.SubType.RoomTicket then
			slot1 = false
		elseif slot0._config.subType == ItemEnum.SubType.SkinTicket then
			slot1 = false
		elseif slot0.viewParam.type == MaterialEnum.MaterialType.NewInsight then
			slot1 = false
		end

		gohelper.setActive(slot0._gouseDetail, slot1)
	else
		gohelper.setActive(slot0._gouse, false)
	end

	if slot0._config.subType ~= ItemEnum.SubType.Portrait then
		slot0._simageequipicon:LoadImage(slot0._icon)
	end

	slot0._txtproptip.text = ""
	slot0._txtexpire.text = ""
	slot0._txtpropname.text = slot0._config.name

	TaskDispatcher.cancelTask(slot0._onRefreshPowerPotionDeadline, slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshItemDeadline, slot0)

	slot1 = slot0._config.subType == ItemEnum.SubType.Portrait

	gohelper.setActive(slot0._goequipicon, false)

	if slot0.viewParam.type == MaterialEnum.MaterialType.PowerPotion then
		slot0:_onRefreshPowerPotionDeadline()
		gohelper.setActive(slot0._simagepropicon.gameObject, true)
		slot0._simagepropicon:LoadImage(slot0._icon)
		TaskDispatcher.runRepeat(slot0._onRefreshPowerPotionDeadline, slot0, 1)
	elseif slot0.viewParam.type == MaterialEnum.MaterialType.NewInsight then
		slot0:_onRefreshNewInsightDeadline()
		gohelper.setActive(slot0._simagepropicon.gameObject, true)
		slot0._simagepropicon:LoadImage(slot0._icon)
		TaskDispatcher.runRepeat(slot0._onRefreshNewInsightDeadline, slot0, 1)
	elseif slot0.viewParam.type == MaterialEnum.MaterialType.Equip then
		gohelper.setActive(slot0._goequipicon, true)
	else
		slot0:_onRefreshItemDeadline()

		if slot1 then
			if not slot0._liveHeadIcon then
				slot0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(slot0._simageheadicon)
			end

			slot0._liveHeadIcon:setLiveHead(slot0._config.id, true)
		else
			if slot0._liveHeadIcon then
				slot0._liveHeadIcon:setVisible(false)
			end

			slot0._simagepropicon:LoadImage(slot0._icon, slot0._setIconNativeSize, slot0)
		end

		gohelper.setActive(slot0._simagepropicon.gameObject, not slot1)
		TaskDispatcher.runRepeat(slot0._onRefreshItemDeadline, slot0, 1)
	end

	slot0._txtdesc.text = ServerTime.ReplaceUTCStr(slot0._config.desc)
	slot0._txtusedesc.text = ServerTime.ReplaceUTCStr(slot0._config.useDesc)

	slot0:_refreshItemQuantity()
	slot0:_refreshItemQuantityVisible()
	gohelper.setActive(slot0._btndetail.gameObject, slot0.viewParam.type == MaterialEnum.MaterialType.Equip)
	gohelper.setActive(slot0._btnplayerbg, slot0.viewParam.type == MaterialEnum.MaterialType.Item and slot0._config.subType == ItemEnum.SubType.PlayerBg)
	gohelper.setActive(slot0._goplayericon, slot0._config.subType == ItemEnum.SubType.Portrait)

	slot2 = slot0._config.subType == ItemEnum.SubType.SummonSimulationPick

	gohelper.setActive(slot0._goSummonsimulationtips, slot2)
	gohelper.setActive(slot0._btnsummonsimulation, slot2)
	gohelper.setActive(slot0._gohadnumber, not (slot0.viewParam.type == MaterialEnum.MaterialType.Exp) and slot0._config.subType ~= ItemEnum.SubType.Portrait and not slot0:_checkIsFakeIcon())
	gohelper.setActive(slot0._goupgrade, slot0._config.subType == ItemEnum.SubType.Portrait and not string.nilorempty(slot0._config.effect))

	slot4 = string.split(slot0._config.effect, "#")

	if slot0._config.subType == ItemEnum.SubType.Portrait then
		if #slot4 > 1 then
			if slot0._config.id == tonumber(slot4[#slot4]) then
				gohelper.setActive(slot0._goupgrade, false)
				gohelper.setActive(slot0._goframe, false)
				gohelper.setActive(slot0._goframenode, true)
				slot0._loader:addPath("ui/viewres/common/effect/frame.prefab")
				slot0._loader:startLoad(slot0._onLoadCallback, slot0)
			end
		else
			gohelper.setActive(slot0._goframe, true)
			gohelper.setActive(slot0._goframenode, false)
		end
	end

	slot0:_refreshValue()
	slot0:_refreshInclude()
	slot0:_cloneJumpItem()

	if slot0:_isUseBtnShow() then
		recthelper.setHeight(slot0._scrolldesc.transform, 180)
	elseif slot0._goinclude.activeInHierarchy then
		recthelper.setHeight(slot0._scrolldesc.transform, 162)
	else
		recthelper.setHeight(slot0._scrolldesc.transform, 415)
	end
end

function slot0._checkIsFakeIcon(slot0)
	if not uv0[slot0.viewParam.type] then
		return false
	end

	return uv0[slot0.viewParam.type][slot0.viewParam.id] or false
end

function slot0._onRefreshPowerPotionDeadline(slot0)
	if slot0._config.expireType ~= 0 and slot0.viewParam.uid then
		if ItemPowerModel.instance:getPowerItemDeadline(slot0.viewParam.uid) <= ServerTime.now() then
			slot0._txtproptip.text = ""
			slot0._txtexpire.text = luaLang("hasExpire")
		else
			slot0._txtproptip.text = slot0:getRemainTimeStr(math.floor(slot1 - ServerTime.now()))
		end
	else
		slot0._txtproptip.text = ""
		slot0._txtexpire.text = ""

		TaskDispatcher.cancelTask(slot0._onRefreshPowerPotionDeadline, slot0)
	end
end

function slot0._onRefreshNewInsightDeadline(slot0)
	if slot0._config.expireType ~= 0 and slot0.viewParam.uid then
		if ItemInsightModel.instance:getInsightItemDeadline(slot0.viewParam.uid) <= ServerTime.now() then
			slot0._txtproptip.text = ""
			slot0._txtexpire.text = luaLang("hasExpire")
		else
			slot0._txtproptip.text = slot0:getRemainTimeStr(math.floor(slot1 - ServerTime.now()))
		end
	else
		slot0._txtproptip.text = slot0:getInsightItemRemainTimeStr(ItemConfig.instance:getInsightItemCo(slot0.viewParam.id).expireHours)
		slot0._txtexpire.text = ""

		TaskDispatcher.cancelTask(slot0._onRefreshNewInsightDeadline, slot0)
	end
end

function slot0.getRemainTimeStr(slot0, slot1)
	return string.format(luaLang("remain"), TimeUtil.getFormatTime_overseas(slot1))
end

function slot0.getInsightItemRemainTimeStr(slot0, slot1)
	return TimeUtil.secondToRoughTime2(slot1 * 3600, false) and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("newinsight_item_detail_remain_time"), slot2) or ""
end

function slot0._onRefreshItemDeadline(slot0)
	if slot0._config.isShow == 1 and slot0._config.isTimeShow == 1 and slot0._config.expireTime and slot0._config.expireTime ~= "" then
		if TimeUtil.stringToTimestamp(slot0._config.expireTime) <= ServerTime.now() then
			slot0._txtproptip.text = ""
			slot0._txtexpire.text = luaLang("hasExpire")
		else
			slot0._txtproptip.text = slot0:getRemainTimeStr(math.floor(slot1 - ServerTime.now()))
		end
	else
		slot0._txtproptip.text = ""
		slot0._txtexpire.text = ""

		TaskDispatcher.cancelTask(slot0._onRefreshItemDeadline, slot0)
	end
end

function slot0._onLoadCallback(slot0)
	gohelper.clone(slot0._loader:getFirstAssetItem():GetResource(), slot0._goframenode, "frame")
end

function slot0._refreshItemQuantity(slot0)
	slot0._txthadnumber.text = formatLuaLang("materialtipview_itemquantity", tostring(GameUtil.numberDisplay(ItemModel.instance:getItemQuantity(slot0.viewParam.type, slot0.viewParam.id, slot0.viewParam.uid, slot0.viewParam.fakeQuantity)) or 0))
end

function slot0._refreshItemQuantityVisible(slot0)
	slot1 = slot0.viewParam.id ~= BpEnum.ScoreItemId

	gohelper.setActive(slot0._gohadnumber, slot1 and not (slot0.viewParam.type == MaterialEnum.MaterialType.Exp))
	gohelper.setActive(slot0._txthadnumber, slot1)
end

function slot0._setIconNativeSize(slot0)
	slot0._simagepropicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
end

function slot0._refreshInclude(slot0)
	slot1 = MaterialEnum.SubTypePackages[slot0._config.subType] == true and slot0.viewParam.inpack ~= true

	gohelper.setActive(slot0._goinclude, slot1)

	slot2 = 0
	slot3 = nil

	if slot1 then
		slot4 = nil

		if slot0._config.subType == ItemEnum.SubType.OptionalGift then
			slot4 = GiftMultipleChoiceListModel.instance:getOptionalGiftInfo(slot0._config.id)
		elseif slot0._config.subType == ItemEnum.SubType.OptionalHeroGift then
			slot4 = {
				[slot9] = {
					4,
					slot10,
					1
				}
			}

			for slot9, slot10 in ipairs(string.splitToNumber(slot0._config.effect, "#")) do
				-- Nothing
			end
		else
			slot4 = GameUtil.splitString2(slot0._config.effect, true)
		end

		slot2 = #slot4

		for slot8, slot9 in ipairs(slot4) do
			if slot0._iconItemList[slot8] == nil then
				slot11 = slot9[1]
				slot3 = slot11

				if slot11 == MaterialEnum.MaterialType.Equip then
					slot10 = IconMgr.instance:getCommonEquipIcon(slot0._goincludeContent)

					slot10:setMOValue(slot11, slot9[2], slot9[3], nil, true)
					slot10:hideLv(true)
					slot10:customClick(function ()
						MaterialTipController.instance:showMaterialInfo(uv0, uv1)
					end)
				elseif slot11 == MaterialEnum.MaterialType.Hero then
					slot10 = IconMgr.instance:getCommonItemIcon(slot0._goincludeContent)

					slot10:setMOValue(slot11, slot12, slot13, nil, true)
					slot10:isShowCount(false)
				else
					slot10 = IconMgr.instance:getCommonItemIcon(slot0._goincludeContent)

					slot10:setMOValue(slot11, slot12, slot13, nil, true)
					slot10:isShowCount(true)
				end

				table.insert(slot0._iconItemList, slot10)
			end

			slot10:setCountFontSize(37.142857142857146)
			gohelper.setActive(slot10.go, true)
		end
	end

	if slot3 == MaterialEnum.MaterialType.Equip then
		slot0._contentHorizontal.spacing = 6.62
		slot0._contentHorizontal.padding.left = -2
		slot0._contentHorizontal.padding.top = 10
	end

	for slot7 = slot2 + 1, #slot0._iconItemList do
		gohelper.setActive(slot0._iconItemList[slot7].go, false)
	end
end

function slot0._isUseBtnShow(slot0)
	if slot0.viewParam.type == MaterialEnum.MaterialType.PowerPotion and slot0.viewParam.inpack and slot0:_isFromBackpackView() then
		return true
	end

	if slot0.viewParam.type == MaterialEnum.MaterialType.NewInsight and slot0.viewParam.inpack and slot0:_isFromBackpackView() then
		return true
	end

	if slot0._config.subType == ItemEnum.SubType.RoomTicket then
		if ViewMgr.instance:isOpen(ViewName.StoreView) then
			return false
		end

		return true
	end

	if slot0._config.subType == ItemEnum.SubType.SkinTicket then
		if ViewMgr.instance:isOpen(ViewName.StoreView) then
			return false
		end

		return ItemModel.instance:getItemQuantity(slot0.viewParam.type, slot0.viewParam.id, slot0.viewParam.uid, slot0.viewParam.fakeQuantity) > 0
	end

	slot1 = ItemConfig.instance:getItemUseCo(slot0._config.subType)

	return slot0.viewParam.inpack and slot1 and slot1.useType ~= 1
end

function slot0._isFromBackpackView(slot0)
	for slot5, slot6 in pairs(ViewMgr.instance:getOpenViewNameList()) do
		if slot6 == ViewName.BackpackView then
			return true
		end
	end

	return false
end

function slot0.statJump(slot0, slot1)
	if slot0.viewParam.id == MaterialEnum.PowerId.SmallPower_Expire or slot0.viewParam.id == MaterialEnum.PowerId.BigPower_Expire then
		slot4 = nil

		if slot1 then
			slot4 = JumpConfig.instance:getJumpConfig(slot1)
		end

		if slot2 then
			StoreController.instance:statOnClickPowerPotionJump(StatEnum.PowerType.Small, slot4.name)
		elseif slot3 then
			StoreController.instance:statOnClickPowerPotionJump(StatEnum.PowerType.Big, slot4.name)
		end
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshPowerPotionDeadline, slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshNewInsightDeadline, slot0)

	slot4 = slot0

	TaskDispatcher.cancelTask(slot0._onRefreshItemDeadline, slot4)

	slot0.viewContainer._isCloseImmediate = true

	for slot4 = 1, #slot0.jumpItemGos do
		slot0.jumpItemGos[slot4].jumpBtn:RemoveClickListener()
	end

	for slot4 = 1, #slot0._boxItemGos do
		slot0._boxItemGos[slot4].jumpBtn:RemoveClickListener()
	end

	if slot0._loader then
		slot0._loader:dispose()

		slot0._loader = nil
	end

	slot0._simagepropicon:UnLoadImage()
	slot0._simageheadicon:UnLoadImage()
	slot0._simageequipicon:UnLoadImage()
	slot0._simagebg1:UnLoadImage()
	slot0._simagebg2:UnLoadImage()
end

return slot0
