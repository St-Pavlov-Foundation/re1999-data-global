module("modules.logic.tips.view.MaterialTipView", package.seeall)

local var_0_0 = class("MaterialTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	local var_1_0 = GMController.instance:getGMNode("materialtipview", arg_1_0.viewGO)

	if var_1_0 then
		arg_1_0._gogm = gohelper.findChild(var_1_0, "#go_gm")
		arg_1_0._txtmattip = gohelper.findChildText(var_1_0, "#go_gm/bg/#txt_mattip")
		arg_1_0._btnone = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_one")
		arg_1_0._btnten = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_ten")
		arg_1_0._btnhundred = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_hundred")
		arg_1_0._btnthousand = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_thousand")
		arg_1_0._btntenthousand = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_tenthousand")
		arg_1_0._btntenmillion = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_tenmillion")
		arg_1_0._btninput = gohelper.findChildButtonWithAudio(var_1_0, "#go_gm/#btn_input")
	end

	arg_1_0._simageblur = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_blur")
	arg_1_0._simagepropicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "iconbg/#simage_propicon")
	arg_1_0._goequipicon = gohelper.findChild(arg_1_0.viewGO, "iconbg/#go_equipicon")
	arg_1_0._simageequipicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "iconbg/#go_equipicon/#simage_equipicon")
	arg_1_0._gohadnumber = gohelper.findChild(arg_1_0.viewGO, "iconbg/#go_hadnumber")
	arg_1_0._txthadnumber = gohelper.findChildText(arg_1_0.viewGO, "iconbg/#go_hadnumber/#txt_hadnumber")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "iconbg/#btn_detail")
	arg_1_0._btnplayerbg = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "iconbg/#btn_playerbg")
	arg_1_0._txtpropname = gohelper.findChildText(arg_1_0.viewGO, "#txt_propname")
	arg_1_0._txtproptip = gohelper.findChildText(arg_1_0.viewGO, "#go_expiretime/#txt_proptip")
	arg_1_0._txtexpire = gohelper.findChildText(arg_1_0.viewGO, "#go_expiretime/#txt_expire")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_desc")
	arg_1_0._gojumptxt = gohelper.findChild(arg_1_0.viewGO, "#scroll_desc/#go_jumptxt")
	arg_1_0._gojumpItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_desc/#go_jumpItem")
	arg_1_0._gosource = gohelper.findChild(arg_1_0.viewGO, "#scroll_desc/viewport/content/#go_source")
	arg_1_0._txtsource = gohelper.findChildText(arg_1_0.viewGO, "#scroll_desc/viewport/content/#go_source/#txt_source")
	arg_1_0._gouse = gohelper.findChild(arg_1_0.viewGO, "#go_use")
	arg_1_0._gouseDetail = gohelper.findChild(arg_1_0.viewGO, "#go_use/#go_usedetail")
	arg_1_0._inputvalue = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_use/#go_usedetail/valuebg/#input_value")
	arg_1_0._btnmin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_use/#go_usedetail/#btn_min")
	arg_1_0._btnsub = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_use/#go_usedetail/#btn_sub")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_use/#go_usedetail/#btn_add")
	arg_1_0._btnmax = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_use/#go_usedetail/#btn_max")
	arg_1_0._btnuse = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_use/#btn_use")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/#btn_close")
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg2")
	arg_1_0._goinclude = gohelper.findChild(arg_1_0.viewGO, "#go_include")
	arg_1_0._goplayericon = gohelper.findChild(arg_1_0.viewGO, "iconbg/#go_playericon")
	arg_1_0._simageheadicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "iconbg/#go_playericon/#simage_headicon")
	arg_1_0._goupgrade = gohelper.findChild(arg_1_0.viewGO, "iconbg/#go_upgrade")
	arg_1_0._goframe = gohelper.findChild(arg_1_0.viewGO, "iconbg/#go_playericon/#go_frame")
	arg_1_0._goframenode = gohelper.findChild(arg_1_0.viewGO, "iconbg/#go_playericon/#go_framenode")
	arg_1_0._goSummonsimulationtips = gohelper.findChild(arg_1_0.viewGO, "#go_summonpicktips")
	arg_1_0._btnsummonsimulation = gohelper.findChildButton(arg_1_0.viewGO, "#btn_summonSiumlationTips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end

	arg_1_0._loader = MultiAbLoader.New()
end

function var_0_0.addEvents(arg_2_0)
	if arg_2_0._btnone then
		arg_2_0._btnone:AddClickListener(arg_2_0._btnoneOnClick, arg_2_0)
	end

	if arg_2_0._btnten then
		arg_2_0._btnten:AddClickListener(arg_2_0._btntenOnClick, arg_2_0)
	end

	if arg_2_0._btnhundred then
		arg_2_0._btnhundred:AddClickListener(arg_2_0._btnhundredOnClick, arg_2_0)
	end

	if arg_2_0._btnthousand then
		arg_2_0._btnthousand:AddClickListener(arg_2_0._btnthousandOnClick, arg_2_0)
	end

	if arg_2_0._btntenthousand then
		arg_2_0._btntenthousand:AddClickListener(arg_2_0._btntenthousandOnClick, arg_2_0)
	end

	if arg_2_0._btntenmillion then
		arg_2_0._btntenmillion:AddClickListener(arg_2_0._btntenmillionOnClick, arg_2_0)
	end

	if arg_2_0._btninput then
		arg_2_0._btninput:AddClickListener(arg_2_0._btninputOnClick, arg_2_0)
	end

	if arg_2_0._btnplayerbg then
		arg_2_0._btnplayerbg:AddClickListener(arg_2_0._btnplayerbgOnClick, arg_2_0)
	end

	if arg_2_0._btnsummonsimulation then
		arg_2_0._btnsummonsimulation:AddClickListener(arg_2_0._btnsummonsimulationOnClick, arg_2_0)
	end

	arg_2_0._btndetail:AddClickListener(arg_2_0._btndetailOnClick, arg_2_0)
	arg_2_0._btnmin:AddClickListener(arg_2_0._btnminOnClick, arg_2_0)
	arg_2_0._btnsub:AddClickListener(arg_2_0._btnsubOnClick, arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
	arg_2_0._btnmax:AddClickListener(arg_2_0._btnmaxOnClick, arg_2_0)
	arg_2_0._btnuse:AddClickListener(arg_2_0._btnuseOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._inputvalue:AddOnEndEdit(arg_2_0._onEndEdit, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	if arg_3_0._btnone then
		arg_3_0._btnone:RemoveClickListener()
	end

	if arg_3_0._btnten then
		arg_3_0._btnten:RemoveClickListener()
	end

	if arg_3_0._btnhundred then
		arg_3_0._btnhundred:RemoveClickListener()
	end

	if arg_3_0._btnthousand then
		arg_3_0._btnthousand:RemoveClickListener()
	end

	if arg_3_0._btntenthousand then
		arg_3_0._btntenthousand:RemoveClickListener()
	end

	if arg_3_0._btntenmillion then
		arg_3_0._btntenmillion:RemoveClickListener()
	end

	if arg_3_0._btninput then
		arg_3_0._btninput:RemoveClickListener()
	end

	if arg_3_0._btnplayerbg then
		arg_3_0._btnplayerbg:RemoveClickListener()
	end

	if arg_3_0._btnsummonsimulation then
		arg_3_0._btnsummonsimulation:RemoveClickListener()
	end

	arg_3_0._btndetail:RemoveClickListener()
	arg_3_0._btnmin:RemoveClickListener()
	arg_3_0._btnsub:RemoveClickListener()
	arg_3_0._btnadd:RemoveClickListener()
	arg_3_0._btnmax:RemoveClickListener()
	arg_3_0._btnuse:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._inputvalue:RemoveOnEndEdit()
end

local var_0_1 = math.floor
local var_0_2 = string.format
local var_0_3 = table.insert
local var_0_4 = {
	[MaterialEnum.MaterialType.Item] = {
		[BpEnum.ScoreItemId] = true
	},
	[MaterialEnum.MaterialType.Currency] = {
		[CurrencyEnum.CurrencyType.V1a6CachotCoin] = true,
		[CurrencyEnum.CurrencyType.V1a6CachotCurrency] = true
	}
}

function var_0_0._btndetailOnClick(arg_4_0)
	if not arg_4_0._canJump then
		GameFacade.showToast(ToastEnum.MaterialTipJump)

		return
	end

	JumpController.instance:jumpByParamWithCondition(var_0_2("51#%d", arg_4_0.viewParam.id), arg_4_0._onJumpFinish, arg_4_0)
end

function var_0_0._btnplayerbgOnClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.PlayerChangeBgView, {
		itemMo = arg_5_0.viewParam
	})
end

function var_0_0._btnsummonsimulationOnClick(arg_6_0)
	if not arg_6_0._config then
		return
	end

	if arg_6_0:_isPackageSkin() then
		HelpController.instance:openBpRuleTipsView(luaLang("ruledetail"), "Rule Details", arg_6_0:_getPackageSkinDesc())
	elseif arg_6_0._config.activityId then
		SummonSimulationPickController.instance:openSummonTips(arg_6_0._config.activityId)
	end
end

function var_0_0._onEndEdit(arg_7_0, arg_7_1)
	arg_7_0._valueChanged = false
	arg_7_0._value = tonumber(arg_7_1)

	if arg_7_0._value > arg_7_0:_getMaxValue() then
		arg_7_0._value = arg_7_0:_getMaxValue()

		arg_7_0._inputvalue:SetText(tostring(arg_7_0._value))

		arg_7_0._valueChanged = true

		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end

	if arg_7_0._value < 1 then
		arg_7_0._value = 1

		arg_7_0._inputvalue:SetText(tostring(arg_7_0._value))

		arg_7_0._valueChanged = true

		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end
end

function var_0_0._btncloseOnClick(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0._btninputOnClick(arg_9_0)
	local var_9_0 = CommonInputMO.New()

	var_9_0.title = "请输入增加道具数量！"
	var_9_0.defaultInput = "Enter Item Num"

	function var_9_0.sureCallback(arg_10_0)
		GameFacade.closeInputBox()

		local var_10_0 = tonumber(arg_10_0)

		if var_10_0 and var_10_0 > 0 then
			arg_9_0:sendGMRequest(var_10_0)
		end
	end

	GameFacade.openInputBox(var_9_0)
end

function var_0_0._btntenmillionOnClick(arg_11_0)
	arg_11_0:sendGMRequest(10000000)
end

function var_0_0._btnoneOnClick(arg_12_0)
	arg_12_0:sendGMRequest(1)
end

function var_0_0._btntenOnClick(arg_13_0)
	arg_13_0:sendGMRequest(10)
end

function var_0_0._btnhundredOnClick(arg_14_0)
	arg_14_0:sendGMRequest(100)
end

function var_0_0._btnthousandOnClick(arg_15_0)
	arg_15_0:sendGMRequest(1000)
end

function var_0_0._btntenthousandOnClick(arg_16_0)
	arg_16_0:sendGMRequest(10000)
end

function var_0_0.sendGMRequest(arg_17_0, arg_17_1)
	GameFacade.showToast(ToastEnum.GMTool5, arg_17_0.viewParam.id)

	if arg_17_0.viewParam.type == MaterialEnum.MaterialType.Item and arg_17_0.viewParam.id == 510001 then
		GMRpc.instance:sendGMRequest(var_0_2("add heroStoryTicket %d", arg_17_1))
	else
		GMRpc.instance:sendGMRequest(var_0_2("add material %d#%d#%d", arg_17_0.viewParam.type, arg_17_0.viewParam.id, arg_17_1))
	end
end

function var_0_0._editableInitView(arg_18_0)
	if arg_18_0._gogm then
		gohelper.setActive(arg_18_0._gogm, GMController.instance:isOpenGM())
	end

	arg_18_0._txtdesc = SLFramework.GameObjectHelper.FindChildComponent(arg_18_0.viewGO, "#scroll_desc/viewport/content/desc", typeof(TMPro.TextMeshProUGUI))
	arg_18_0._txtusedesc = SLFramework.GameObjectHelper.FindChildComponent(arg_18_0.viewGO, "#scroll_desc/viewport/content/usedesc", typeof(TMPro.TextMeshProUGUI))

	gohelper.setActive(arg_18_0._gojumpItem, false)
	gohelper.setActive(arg_18_0._gojumptxt, false)

	arg_18_0.jumpItemGos = {}
	arg_18_0._boxItemGos = {}
	arg_18_0._iconItemList = {}
	arg_18_0._value = 1
	arg_18_0._goincludeContent = gohelper.findChild(arg_18_0._goinclude, "#scroll_product/viewport/content")
	arg_18_0._contentHorizontal = arg_18_0._goincludeContent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))

	arg_18_0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_18_0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))

	arg_18_0._txtsource.text = luaLang("materialview_source")
	arg_18_0._txtSummonsimulationtips = gohelper.findChildText(arg_18_0._goSummonsimulationtips, "txt_tips")
end

function var_0_0._cloneJumpItem(arg_19_0)
	local var_19_0 = gohelper.findChild(arg_19_0.viewGO, "#scroll_desc/viewport/content")

	arg_19_0._scrolldesc.verticalNormalizedPosition = 1

	local var_19_1 = {}
	local var_19_2 = ViewMgr.instance:isOpen(ViewName.GiftMultipleChoiceView)
	local var_19_3 = ItemModel.instance:getOptionalGiftBySubTypeAndRare(arg_19_0._config.subType, arg_19_0._config.rare, arg_19_0._config.id)

	if var_19_3 then
		for iter_19_0, iter_19_1 in pairs(var_19_3) do
			local var_19_4 = {}

			var_19_4.sourceId = 1
			var_19_4.sourceParam = iter_19_1.id

			table.insert(var_19_1, var_19_4)
		end
	end

	if not string.nilorempty(arg_19_0._config.boxOpen) and not var_19_2 then
		local var_19_5 = string.split(arg_19_0._config.boxOpen, "|")

		for iter_19_2, iter_19_3 in ipairs(var_19_5) do
			local var_19_6 = string.splitToNumber(iter_19_3, "#")
			local var_19_7 = {
				sourceId = var_19_6[1],
				sourceParam = var_19_6[2]
			}

			table.insert(var_19_1, var_19_7)
		end
	end

	if var_19_1 then
		for iter_19_4, iter_19_5 in ipairs(var_19_1) do
			if ItemModel.instance:getItemCount(iter_19_5.sourceParam) > 0 then
				if not arg_19_0._boxItemGos[iter_19_4] then
					local var_19_8 = gohelper.clone(arg_19_0._gojumpItem, var_19_0, "boxitem" .. iter_19_4)
					local var_19_9 = arg_19_0:getUserDataTb_()

					var_19_9.go = var_19_8
					var_19_9.layout = gohelper.findChild(var_19_8, "layout"):GetComponent(typeof(ZProj.LimitedScrollRect))
					var_19_9.originText = gohelper.findChildText(var_19_8, "layout/Viewport/Content/originText")
					var_19_9.indexText = gohelper.findChildText(var_19_8, "indexText")
					var_19_9.jumpBtn = gohelper.findChildButtonWithAudio(var_19_8, "jump/jumpBtn")
					var_19_9.hasjump = gohelper.findChild(var_19_8, "jump")
					var_19_9.jumpText = gohelper.findChildText(var_19_8, "jump/jumpBtn/jumpText")
					var_19_9.jumpHardTagGO = gohelper.findChild(var_19_8, "layout/Viewport/Content/hardtag")
					var_19_9.jumpBgGO = gohelper.findChild(var_19_8, "jump/bg")
					var_19_9.probalityBg = gohelper.findChild(var_19_8, "layout/Viewport/Content/bg")
					var_19_9.txtProbality = gohelper.findChildText(var_19_8, "layout/Viewport/Content/bg/probality")

					local var_19_10 = var_19_1.episodeId and var_19_1.probability and MaterialEnum.JumpProbabilityDisplay[var_19_1.probability]

					var_19_9.txtProbality.text = var_19_10 and string.format("%s", luaLang(MaterialEnum.JumpProbabilityDisplay[var_19_1.probability])) or ""

					gohelper.setActive(var_19_9.probalityBg, var_19_10 and true or false)
					gohelper.setActive(var_19_9.jumpHardTagGO, false)

					local var_19_11 = ItemConfig.instance:getItemCo(tonumber(iter_19_5.sourceParam)).name

					var_19_9.jumpText.text = luaLang("MaterialTipView_jumpText_unlock")
					var_19_9.originText.text = var_0_2("<color=#3f485f><size=32>%s</size></color>", var_0_2(luaLang("material_storage"), var_19_11))
					var_19_9.indexText.text = ""

					table.insert(arg_19_0._boxItemGos, var_19_9)

					var_19_9.layout.parentGameObject = arg_19_0._scrolldesc.gameObject

					var_19_9.jumpBtn:AddClickListener(function(arg_20_0)
						local var_20_0 = ItemModel.instance:getItemCount(arg_19_0._config.id)
						local var_20_1 = ItemModel.instance:getItemCount(iter_19_5.sourceParam)

						GiftModel.instance:reset()

						if arg_19_0.viewParam.needQuantity then
							if var_20_0 > arg_19_0.viewParam.needQuantity or not arg_19_0.viewParam.isConsume then
								arg_19_0._value = 1
							else
								if var_20_1 > arg_19_0.viewParam.needQuantity - var_20_0 then
									arg_19_0._value = arg_19_0.viewParam.needQuantity - var_20_0 == 0 and 1 or arg_19_0.viewParam.needQuantity - var_20_0
								else
									arg_19_0._value = var_20_1
								end

								if var_20_0 < arg_19_0.viewParam.needQuantity then
									GiftModel.instance:setNeedGift(arg_19_0.viewParam.id)
								end
							end
						else
							arg_19_0._value = 1
						end

						MaterialTipController.instance:showMaterialInfo(iter_19_5.sourceId, iter_19_5.sourceParam, true)
					end, var_19_9)
				end

				gohelper.setActive(arg_19_0._boxItemGos[iter_19_4].go, true)
			elseif arg_19_0._boxItemGos[iter_19_4] then
				gohelper.setActive(arg_19_0._boxItemGos[iter_19_4].go, false)
			end
		end
	end

	local var_19_12 = arg_19_0._config.sources
	local var_19_13 = {}

	if not string.nilorempty(var_19_12) then
		local var_19_14 = string.split(var_19_12, "|")

		for iter_19_6, iter_19_7 in ipairs(var_19_14) do
			local var_19_15 = string.splitToNumber(iter_19_7, "#")
			local var_19_16 = {
				sourceId = var_19_15[1],
				probability = var_19_15[2]
			}

			var_19_16.episodeId = JumpConfig.instance:getJumpEpisodeId(var_19_16.sourceId)

			if JumpConfig.instance:isOpenJumpId(var_19_16.sourceId) and (var_19_16.probability ~= MaterialEnum.JumpProbability.Normal or not DungeonModel.instance:hasPassLevel(var_19_16.episodeId)) then
				table.insert(var_19_13, var_19_16)
			end
		end
	end

	local var_19_17 = DungeonConfig.instance:getMaterialSource(arg_19_0.viewParam.type, arg_19_0.viewParam.id)

	if var_19_17 then
		for iter_19_8, iter_19_9 in ipairs(var_19_17) do
			local var_19_18 = {}

			var_19_18.sourceId = -1
			var_19_18.probability = iter_19_9.probability
			var_19_18.episodeId = iter_19_9.episodeId
			var_19_18.jumpParam = var_0_2("4#%s", iter_19_9.episodeId)

			local var_19_19 = false
			local var_19_20 = iter_19_9.episodeId and DungeonConfig.instance:getEpisodeCO(iter_19_9.episodeId)

			if var_19_20 then
				var_19_19 = ResSplitConfig.instance:isSaveChapter(var_19_20.chapterId)
			end

			var_19_18.isOpen = var_19_19

			table.insert(var_19_13, var_19_18)
		end
	end

	for iter_19_10 = 1, #var_19_13 do
		local var_19_21 = arg_19_0.jumpItemGos[iter_19_10]

		if not var_19_21 then
			local var_19_22 = gohelper.clone(arg_19_0._gojumpItem, var_19_0, "item" .. iter_19_10)

			var_19_21 = arg_19_0:getUserDataTb_()
			var_19_21.go = var_19_22
			var_19_21.layout = gohelper.findChild(var_19_22, "layout"):GetComponent(typeof(ZProj.LimitedScrollRect))
			var_19_21.originText = gohelper.findChildText(var_19_22, "layout/Viewport/Content/originText")
			var_19_21.indexText = gohelper.findChildText(var_19_22, "indexText")
			var_19_21.jumpBtn = gohelper.findChildButtonWithAudio(var_19_22, "jump/jumpBtn")
			var_19_21.hasjump = gohelper.findChild(var_19_22, "jump")
			var_19_21.jumpText = gohelper.findChildText(var_19_22, "jump/jumpBtn/jumpText")
			var_19_21.jumpHardTagGO = gohelper.findChild(var_19_22, "layout/Viewport/Content/hardtag")
			var_19_21.jumpBgGO = gohelper.findChild(var_19_22, "jump/bg")
			var_19_21.probalityBg = gohelper.findChild(var_19_22, "layout/Viewport/Content/bg")
			var_19_21.txtProbality = gohelper.findChildText(var_19_22, "layout/Viewport/Content/bg/probality")

			table.insert(arg_19_0.jumpItemGos, var_19_21)

			var_19_21.layout.parentGameObject = arg_19_0._scrolldesc.gameObject

			var_19_21.jumpBtn:AddClickListener(function(arg_21_0)
				if arg_21_0.cantJumpTips then
					GameFacade.showToastWithTableParam(arg_21_0.cantJumpTips, arg_21_0.cantJumpParam)
				elseif arg_21_0.canJump then
					if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.ForceJumpToMainView) then
						NavigateButtonsView.homeClick()

						return
					end

					if arg_21_0.jumpParam then
						ViewMgr.instance:closeView(ViewName.RoomInitBuildingView)
						JumpController.instance:jumpTo(arg_21_0.jumpParam, arg_19_0._onJumpFinish, arg_19_0, arg_19_0.viewParam.recordFarmItem)
					else
						JumpController.instance:dispatchEvent(JumpEvent.JumpBtnClick, arg_21_0.jumpId)
						GameFacade.jump(arg_21_0.jumpId, arg_19_0._onJumpFinish, arg_19_0, arg_19_0.viewParam.recordFarmItem)
						arg_19_0:statJump(arg_21_0.jumpId)
					end
				else
					GameFacade.showToast(ToastEnum.MaterialTipJump)
				end
			end, var_19_21)
		end

		local var_19_23 = var_19_13[iter_19_10]

		var_19_21.canJump = arg_19_0._canJump
		var_19_21.jumpId = var_19_23.sourceId
		var_19_21.jumpParam = var_19_23.jumpParam

		local var_19_24 = var_19_23.sourceId ~= -1 and JumpConfig.instance:getJumpConfig(var_19_23.sourceId)
		local var_19_25 = ""
		local var_19_26 = ""

		if var_19_23.sourceId == -1 then
			var_19_25, var_19_26 = JumpConfig.instance:getEpisodeNameAndIndex(var_19_23.episodeId)
		elseif string.nilorempty(var_19_24.param) then
			var_19_25 = var_19_24.name
		else
			var_19_25, var_19_26 = JumpConfig.instance:getJumpName(var_19_23.sourceId)
		end

		var_19_21.originText.text = var_19_25 or ""
		var_19_21.indexText.text = var_19_26 or ""

		local var_19_27 = var_19_23.episodeId and var_19_23.probability and MaterialEnum.JumpProbabilityDisplay[var_19_23.probability]

		var_19_21.txtProbality.text = var_19_27 and var_0_2("%s", luaLang(MaterialEnum.JumpProbabilityDisplay[var_19_23.probability])) or ""
		var_19_21.jumpText.text = luaLang("p_materialtip_jump")

		gohelper.setActive(var_19_21.probalityBg, var_19_27 and true or false)

		local var_19_28 = var_19_24 and var_19_24.param or var_19_23.jumpParam
		local var_19_29

		if var_19_23.sourceId == -1 then
			var_19_29 = var_19_23.isOpen
		elseif var_19_23.sourceId == JumpEnum.BPChargeView then
			var_19_29 = not BpModel.instance:isEnd() and JumpController.instance:isJumpOpen(var_19_23.sourceId)
		else
			var_19_29 = JumpController.instance:isJumpOpen(var_19_23.sourceId)
		end

		local var_19_30
		local var_19_31

		if not var_19_29 and var_19_23.sourceId ~= -1 then
			var_19_30, var_19_31 = OpenHelper.getToastIdAndParam(var_19_24.openId)
		else
			var_19_30, var_19_31 = JumpController.instance:cantJump(var_19_28)
		end

		local var_19_32 = string.split(var_19_28, "#")

		if tonumber(var_19_32[1]) == JumpEnum.JumpView.RoomProductLineView and not var_19_30 then
			local var_19_33
			local var_19_34
			local var_19_35
			local var_19_36, var_19_37, var_19_38 = RoomProductionHelper.isChangeFormulaUnlock(arg_19_0.viewParam.type, arg_19_0.viewParam.id)
			local var_19_39 = var_19_38
			local var_19_40 = var_19_37

			if not var_19_36 then
				var_19_30 = var_19_40
				var_19_31 = var_19_39 and {
					var_19_39
				} or nil
			end
		end

		local var_19_41 = var_19_23.sourceId ~= -1 and JumpController.instance:isOnlyShowJump(var_19_23.sourceId)

		gohelper.setActive(var_19_21.hasjump, not var_19_41)
		ZProj.UGUIHelper.SetGrayscale(var_19_21.jumpText.gameObject, var_19_30 ~= nil)
		ZProj.UGUIHelper.SetGrayscale(var_19_21.jumpBgGO, var_19_30 ~= nil)

		var_19_21.cantJumpTips = var_19_30
		var_19_21.cantJumpParam = var_19_31

		gohelper.setActive(var_19_21.jumpHardTagGO, JumpConfig.instance:isJumpHardDungeon(var_19_23.episodeId))
		gohelper.setActive(var_19_21.go, true)
	end

	gohelper.setActive(arg_19_0._gosource, #var_19_13 > 0 or #var_19_1 > 0)

	for iter_19_11 = #var_19_1 + 1, #arg_19_0._boxItemGos do
		gohelper.setActive(arg_19_0._boxItemGos[iter_19_11].go, false)
	end

	for iter_19_12 = #var_19_13 + 1, #arg_19_0.jumpItemGos do
		gohelper.setActive(arg_19_0.jumpItemGos[iter_19_12].go, false)
	end
end

function var_0_0._setJumpMaxIndexWidth(arg_22_0, arg_22_1)
	local var_22_0 = 0

	for iter_22_0 = 1, arg_22_1 do
		local var_22_1 = arg_22_0.jumpItemGos[iter_22_0]

		if var_22_1 then
			local var_22_2 = var_22_1.indexText.preferredWidth

			if var_22_0 < var_22_2 then
				var_22_0 = var_22_2
			end
		end
	end

	for iter_22_1 = 1, arg_22_1 do
		local var_22_3 = arg_22_0.jumpItemGos[iter_22_1]

		if var_22_3 then
			local var_22_4 = var_22_3.indexText.text

			recthelper.setAnchorX(var_22_3.originText.transform, var_22_0 > 0 and var_22_0 + 15 or -4)
		end
	end
end

function var_0_0._onJumpFinish(arg_23_0)
	ViewMgr.instance:closeView(ViewName.MaterialPackageTipView)
	arg_23_0:closeThis()

	if arg_23_0.viewParam.jumpFinishCallback then
		arg_23_0.viewParam.jumpFinishCallback(arg_23_0.viewParam.jumpFinishCallbackObj, arg_23_0.viewParam.jumpFinishCallbackParam)
	end
end

function var_0_0._btnuseOnClick(arg_24_0)
	if arg_24_0._valueChanged then
		arg_24_0._valueChanged = false

		return
	end

	arg_24_0._value = tonumber(arg_24_0._inputvalue:GetText())

	if arg_24_0._value > arg_24_0:_getMaxValue() then
		arg_24_0._value = arg_24_0:_getMaxValue()

		arg_24_0._inputvalue:SetText(tostring(arg_24_0._value))
		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end

	if arg_24_0._value < 1 then
		arg_24_0._value = 1

		arg_24_0._inputvalue:SetText(tostring(arg_24_0._value))
		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end

	local var_24_0 = arg_24_0._config.id
	local var_24_1 = arg_24_0._value

	if arg_24_0.viewParam.type == MaterialEnum.MaterialType.PowerPotion then
		CurrencyController.instance:openPowerView()

		return
	elseif arg_24_0.viewParam.type == MaterialEnum.MaterialType.NewInsight then
		arg_24_0:closeThis()
		GiftController.instance:openGiftInsightHeroChoiceView(arg_24_0.viewParam)

		return
	end

	if arg_24_0:_isSummonSkin() then
		MaterialTipController.instance:_openView_LifeCirclePickChoice(arg_24_0._config, var_24_1)
	elseif arg_24_0:_isPackageSkin() then
		CharacterModel.instance:setGainHeroViewShowState(false)
		CharacterModel.instance:setGainHeroViewNewShowState(false)
		ItemRpc.instance:simpleSendUseItemRequest(var_24_0, var_24_1)
	elseif arg_24_0._config.subType == ItemEnum.SubType.SpecifiedGift then
		local var_24_2 = {
			param = arg_24_0.viewParam,
			quantity = var_24_1,
			subType = arg_24_0._config.subType
		}

		GiftController.instance:openGiftMultipleChoiceView(var_24_2)
	elseif arg_24_0._config.subType == ItemEnum.SubType.OptionalGift then
		local var_24_3 = {
			param = arg_24_0.viewParam,
			quantity = var_24_1,
			subType = arg_24_0._config.subType
		}

		GiftController.instance:openOptionalGiftMultipleChoiceView(var_24_3)
	elseif arg_24_0._config.subType == ItemEnum.SubType.OptionalHeroGift then
		if string.nilorempty(arg_24_0._config.effect) then
			return
		end

		local var_24_4 = string.splitToNumber(arg_24_0._config.effect, "#")
		local var_24_5 = CustomPickChoiceEnum.style.OptionalHeroGift
		local var_24_6 = {
			id = arg_24_0._config.id,
			quantity = var_24_1,
			styleId = var_24_5
		}

		if arg_24_0._config.id == ItemEnum.NewbiePackGiftId then
			CustomPickChoiceController.instance:openNewBiePickChoiceView(var_24_4, MaterialTipController.onUseOptionalHeroGift, MaterialTipController, var_24_6)
		else
			CustomPickChoiceController.instance:openCustomPickChoiceView(var_24_4, MaterialTipController.onUseOptionalHeroGift, MaterialTipController, var_24_6)
		end
	elseif arg_24_0._config.subType == ItemEnum.SubType.SkinTicket then
		StoreController.instance:openStoreView(500)
	elseif arg_24_0._config.subType == ItemEnum.SubType.DecorateDiscountTicket then
		StoreController.instance:openStoreView(801)
	elseif arg_24_0._config.subType == ItemEnum.SubType.RoomTicket then
		GameFacade.showMessageBox(MessageBoxIdDefine.GoToUseRoomTicket, MsgBoxEnum.BoxType.Yes_No, arg_24_0._useRoomTicket, nil, nil, arg_24_0, nil, nil)
	elseif arg_24_0._config.subType == ItemEnum.SubType.SummonSimulationPick then
		local var_24_7 = arg_24_0._config.activityId

		arg_24_0:_tryUseSummonSimulation(var_24_7)

		return
	elseif arg_24_0._config.subType == ItemEnum.SubType.SelfSelectSix then
		if string.nilorempty(arg_24_0._config.effect) then
			return
		end

		local var_24_8 = string.split(arg_24_0._config.effect, "|")
		local var_24_9 = {
			quantity = 1,
			id = arg_24_0._config.id
		}

		V2a7_SelfSelectSix_PickChoiceController.instance:openCustomPickChoiceView(var_24_8, MaterialTipController.onUseSelfSelectSixHeroGift, MaterialTipController, var_24_9)
	elseif arg_24_0._config.subType == ItemEnum.SubType.DestinyStoneUp then
		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DestinyStone) then
			local var_24_10 = lua_open.configDict[OpenEnum.UnlockFunc.DestinyStone].episodeId

			if not DungeonModel.instance:hasPassLevel(var_24_10) then
				local var_24_11 = DungeonConfig.instance:getEpisodeDisplay(var_24_10)

				GameFacade.showToast(ToastEnum.DungeonMapLevel, var_24_11)
			end

			return
		end

		local var_24_12 = HeroModel.instance:getAllHero()
		local var_24_13 = {}

		for iter_24_0, iter_24_1 in pairs(var_24_12) do
			if iter_24_1 and arg_24_0:checkHeroOpenDestinyStone(iter_24_1) and not iter_24_1.destinyStoneMo:checkAllUnlock() then
				table.insert(var_24_13, iter_24_1)
			end
		end

		if #var_24_13 > 0 then
			ViewMgr.instance:openView(ViewName.DestinyStoneGiftPickChoiceView)
		else
			GameFacade.showToast(ToastEnum.NoHeroCanDestinyUp)
		end
	else
		ItemRpc.instance:simpleSendUseItemRequest(var_24_0, var_24_1)
	end

	arg_24_0:closeThis()
end

function var_0_0.checkHeroOpenDestinyStone(arg_25_0, arg_25_1)
	if not arg_25_1:isHasDestinySystem() then
		return false
	end

	local var_25_0 = arg_25_1.config.rare or 5
	local var_25_1 = CharacterDestinyEnum.DestinyStoneOpenLevelConstId[var_25_0]
	local var_25_2 = CommonConfig.instance:getConstStr(var_25_1)

	if arg_25_1.level >= tonumber(var_25_2) then
		return true
	end

	return false
end

function var_0_0._useRoomTicket(arg_26_0)
	GameFacade.jump(JumpEnum.JumpId.RoomStore, arg_26_0._onJumpFinish, arg_26_0)
end

function var_0_0._tryUseSummonSimulation(arg_27_0, arg_27_1)
	SummonSimulationPickController.instance:registerCallback(SummonSimulationEvent.onGetSummonInfo, arg_27_0._realUseSummonSimulation, arg_27_0)
	SummonSimulationPickController.instance:getActivityInfo(arg_27_1)
end

function var_0_0._realUseSummonSimulation(arg_28_0, arg_28_1)
	SummonSimulationPickController.instance:unregisterCallback(SummonSimulationEvent.onGetSummonInfo, arg_28_0._realUseSummonSimulation, arg_28_0)
	SummonSimulationPickController.instance:trySummonSimulation(arg_28_1)
	arg_28_0:closeThis()
end

function var_0_0._btnaddOnClick(arg_29_0)
	if arg_29_0._valueChanged then
		arg_29_0._valueChanged = false

		return
	end

	arg_29_0._value = tonumber(arg_29_0._inputvalue:GetText())

	if arg_29_0._value >= arg_29_0:_getMaxValue() then
		arg_29_0._value = arg_29_0:_getMaxValue()

		arg_29_0._inputvalue:SetText(tostring(arg_29_0._value))
		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end

	arg_29_0._value = arg_29_0._value + 1

	arg_29_0:_refreshValue()
end

function var_0_0._btnsubOnClick(arg_30_0)
	if arg_30_0._valueChanged then
		arg_30_0._valueChanged = false

		return
	end

	arg_30_0._value = tonumber(arg_30_0._inputvalue:GetText())

	if arg_30_0._value <= 1 then
		arg_30_0._value = 1

		arg_30_0._inputvalue:SetText(tostring(arg_30_0._value))
		GameFacade.showToast(ToastEnum.MaterialTipBtnSub)

		return
	end

	arg_30_0._value = arg_30_0._value - 1

	arg_30_0:_refreshValue()
end

function var_0_0._btnmaxOnClick(arg_31_0)
	arg_31_0._value = arg_31_0:_getMaxValue()

	arg_31_0:_refreshValue()
end

function var_0_0._btnminOnClick(arg_32_0)
	arg_32_0._value = 1

	arg_32_0:_refreshValue()
end

function var_0_0.onDestroyView(arg_33_0)
	return
end

function var_0_0._refreshValue(arg_34_0)
	arg_34_0._inputvalue:SetText(tostring(arg_34_0._value))
end

function var_0_0._getMaxValue(arg_35_0)
	if arg_35_0._config.isStackable == 1 then
		local var_35_0 = ItemModel.instance:getItemCount(arg_35_0._config.id)
		local var_35_1 = ItemConfig.instance:getItemUseCo(arg_35_0._config.subType)

		if var_35_1.useType == 2 then
			return 1
		elseif var_35_1.useType == 6 then
			return var_35_0 > var_35_1.use_max and var_35_1.use_max or var_35_0
		end
	end

	return 1
end

function var_0_0.onOpen(arg_36_0)
	arg_36_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_36_0._refreshItemQuantity, arg_36_0)
	arg_36_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_36_0._refreshItemQuantity, arg_36_0)
	arg_36_0:addGmBtnAudio()
	arg_36_0:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Tipsopen)
end

function var_0_0.onUpdateParam(arg_37_0)
	arg_37_0:_refreshUI()
end

function var_0_0.addGmBtnAudio(arg_38_0)
	if arg_38_0._btnone then
		gohelper.addUIClickAudio(arg_38_0._btnone.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if arg_38_0._btnten then
		gohelper.addUIClickAudio(arg_38_0._btnten.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if arg_38_0._btnhundred then
		gohelper.addUIClickAudio(arg_38_0._btnhundred.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if arg_38_0._btnthousand then
		gohelper.addUIClickAudio(arg_38_0._btnthousand.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if arg_38_0._btntenthousand then
		gohelper.addUIClickAudio(arg_38_0._btntenthousand.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if arg_38_0._btntenmillion then
		gohelper.addUIClickAudio(arg_38_0._btntenmillion.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end

	if arg_38_0._btninput then
		gohelper.addUIClickAudio(arg_38_0._btninput.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	end
end

function var_0_0._refreshUI(arg_39_0)
	arg_39_0._canJump = arg_39_0.viewParam.canJump

	if arg_39_0._txtmattip then
		arg_39_0._txtmattip.text = tostring(arg_39_0.viewParam.type) .. "#" .. tostring(arg_39_0.viewParam.id)
	end

	arg_39_0._config, arg_39_0._icon = ItemModel.instance:getItemConfigAndIcon(arg_39_0.viewParam.type, arg_39_0.viewParam.id)

	if arg_39_0.viewParam.type == MaterialEnum.MaterialType.Equip then
		arg_39_0._icon = ResUrl.getEquipIcon(arg_39_0._config.icon)
	elseif arg_39_0._config.subType == ItemEnum.SubType.Portrait then
		arg_39_0._icon = ResUrl.getPlayerHeadIcon(arg_39_0._config.icon)
	end

	gohelper.setActive(arg_39_0._simagepropicon.gameObject, false)

	if arg_39_0:_isUseBtnShow() then
		gohelper.setActive(arg_39_0._gouse, true)

		local var_39_0 = true

		if arg_39_0.viewParam.type == MaterialEnum.MaterialType.PowerPotion then
			var_39_0 = false
		elseif arg_39_0._config.subType == ItemEnum.SubType.RoomTicket then
			var_39_0 = false
		elseif arg_39_0._config.subType == ItemEnum.SubType.SkinTicket then
			var_39_0 = false
		elseif arg_39_0._config.subType == ItemEnum.SubType.DecorateDiscountTicket then
			var_39_0 = false
		elseif arg_39_0.viewParam.type == MaterialEnum.MaterialType.NewInsight then
			var_39_0 = false
		elseif arg_39_0._config.subType == ItemEnum.SubType.SelfSelectSix then
			var_39_0 = false

			recthelper.setAnchorY(arg_39_0._btnuse.transform, -190)
		end

		gohelper.setActive(arg_39_0._gouseDetail, var_39_0)
	else
		gohelper.setActive(arg_39_0._gouse, false)
	end

	if arg_39_0._config.subType ~= ItemEnum.SubType.Portrait then
		arg_39_0._simageequipicon:LoadImage(arg_39_0._icon)
	end

	arg_39_0._txtproptip.text = ""
	arg_39_0._txtexpire.text = ""
	arg_39_0._txtpropname.text = arg_39_0._config.name

	TaskDispatcher.cancelTask(arg_39_0._onRefreshPowerPotionDeadline, arg_39_0)
	TaskDispatcher.cancelTask(arg_39_0._onRefreshItemDeadline, arg_39_0)

	local var_39_1 = arg_39_0._config.subType == ItemEnum.SubType.Portrait

	gohelper.setActive(arg_39_0._goequipicon, false)

	if arg_39_0.viewParam.type == MaterialEnum.MaterialType.PowerPotion then
		arg_39_0:_onRefreshPowerPotionDeadline()
		gohelper.setActive(arg_39_0._simagepropicon.gameObject, true)
		arg_39_0._simagepropicon:LoadImage(arg_39_0._icon)
		TaskDispatcher.runRepeat(arg_39_0._onRefreshPowerPotionDeadline, arg_39_0, 1)
	elseif arg_39_0.viewParam.type == MaterialEnum.MaterialType.NewInsight then
		arg_39_0:_onRefreshNewInsightDeadline()
		gohelper.setActive(arg_39_0._simagepropicon.gameObject, true)
		arg_39_0._simagepropicon:LoadImage(arg_39_0._icon)
		TaskDispatcher.runRepeat(arg_39_0._onRefreshNewInsightDeadline, arg_39_0, 1)
	elseif arg_39_0.viewParam.type == MaterialEnum.MaterialType.Equip then
		gohelper.setActive(arg_39_0._goequipicon, true)
	else
		arg_39_0:_onRefreshItemDeadline()

		if var_39_1 then
			if not arg_39_0._liveHeadIcon then
				arg_39_0._liveHeadIcon = IconMgr.instance:getCommonLiveHeadIcon(arg_39_0._simageheadicon)
			end

			arg_39_0._liveHeadIcon:setLiveHead(arg_39_0._config.id, true)
		else
			if arg_39_0._liveHeadIcon then
				arg_39_0._liveHeadIcon:setVisible(false)
			end

			arg_39_0._simagepropicon:LoadImage(arg_39_0._icon, arg_39_0._setIconNativeSize, arg_39_0)
		end

		gohelper.setActive(arg_39_0._simagepropicon.gameObject, not var_39_1)
		TaskDispatcher.runRepeat(arg_39_0._onRefreshItemDeadline, arg_39_0, 1)
	end

	arg_39_0._txtdesc.text = ServerTime.ReplaceUTCStr(arg_39_0._config.desc)
	arg_39_0._txtusedesc.text = ServerTime.ReplaceUTCStr(arg_39_0._config.useDesc)

	arg_39_0:_refreshItemQuantity()
	arg_39_0:_refreshItemQuantityVisible()
	gohelper.setActive(arg_39_0._btndetail.gameObject, arg_39_0.viewParam.type == MaterialEnum.MaterialType.Equip)
	gohelper.setActive(arg_39_0._btnplayerbg, false)
	gohelper.setActive(arg_39_0._goplayericon, arg_39_0._config.subType == ItemEnum.SubType.Portrait)

	local var_39_2 = arg_39_0._config.subType == ItemEnum.SubType.SummonSimulationPick
	local var_39_3 = var_39_2 or arg_39_0:_isPackageSkin()

	gohelper.setActive(arg_39_0._goSummonsimulationtips, var_39_3)
	gohelper.setActive(arg_39_0._btnsummonsimulation, var_39_3)

	local var_39_4 = arg_39_0.viewParam.type == MaterialEnum.MaterialType.Exp

	gohelper.setActive(arg_39_0._gohadnumber, not var_39_4 and arg_39_0._config.subType ~= ItemEnum.SubType.Portrait and not arg_39_0:_checkIsFakeIcon())
	gohelper.setActive(arg_39_0._goupgrade, arg_39_0._config.subType == ItemEnum.SubType.Portrait and not string.nilorempty(arg_39_0._config.effect))

	local var_39_5 = string.split(arg_39_0._config.effect, "#")

	if arg_39_0._config.subType == ItemEnum.SubType.Portrait then
		if #var_39_5 > 1 then
			if arg_39_0._config.id == tonumber(var_39_5[#var_39_5]) then
				gohelper.setActive(arg_39_0._goupgrade, false)
				gohelper.setActive(arg_39_0._goframe, false)
				gohelper.setActive(arg_39_0._goframenode, true)

				local var_39_6 = "ui/viewres/common/effect/frame.prefab"

				arg_39_0._loader:addPath(var_39_6)
				arg_39_0._loader:startLoad(arg_39_0._onLoadCallback, arg_39_0)
			end
		else
			gohelper.setActive(arg_39_0._goframe, true)
			gohelper.setActive(arg_39_0._goframenode, false)
		end
	end

	arg_39_0:_refreshValue()
	arg_39_0:_refreshInclude()
	arg_39_0:_cloneJumpItem()

	if arg_39_0:_isUseBtnShow() then
		recthelper.setHeight(arg_39_0._scrolldesc.transform, 180)
	elseif arg_39_0._goinclude.activeInHierarchy then
		recthelper.setHeight(arg_39_0._scrolldesc.transform, 162)
	else
		recthelper.setHeight(arg_39_0._scrolldesc.transform, 415)
	end

	if var_39_3 then
		if var_39_2 then
			arg_39_0._txtSummonsimulationtips.text = luaLang("p_normalstoregoodsview_txt_summonpicktips")
		end

		if arg_39_0:_isPackageSkin() then
			arg_39_0._txtSummonsimulationtips.text = luaLang("ruledetail")
		end
	end
end

function var_0_0._checkIsFakeIcon(arg_40_0)
	if not var_0_4[arg_40_0.viewParam.type] then
		return false
	end

	return var_0_4[arg_40_0.viewParam.type][arg_40_0.viewParam.id] or false
end

function var_0_0._onRefreshPowerPotionDeadline(arg_41_0)
	local var_41_0 = ItemPowerModel.instance:getPowerItemDeadline(arg_41_0.viewParam.uid)

	if arg_41_0._config.expireType ~= 0 and arg_41_0.viewParam.uid then
		if var_41_0 <= ServerTime.now() then
			arg_41_0._txtproptip.text = ""
			arg_41_0._txtexpire.text = luaLang("hasExpire")
		else
			local var_41_1 = math.floor(var_41_0 - ServerTime.now())

			arg_41_0._txtproptip.text = arg_41_0:getRemainTimeStr(var_41_1)
		end
	else
		arg_41_0._txtproptip.text = ""
		arg_41_0._txtexpire.text = ""

		TaskDispatcher.cancelTask(arg_41_0._onRefreshPowerPotionDeadline, arg_41_0)
	end
end

function var_0_0._onRefreshNewInsightDeadline(arg_42_0)
	local var_42_0 = ItemInsightModel.instance:getInsightItemDeadline(arg_42_0.viewParam.uid)

	if arg_42_0._config.expireHours == ItemEnum.NoExpiredNum then
		arg_42_0._txtproptip.text = ""
		arg_42_0._txtexpire.text = ""
	elseif arg_42_0._config.expireType ~= 0 and arg_42_0.viewParam.uid then
		if var_42_0 <= ServerTime.now() then
			arg_42_0._txtproptip.text = ""
			arg_42_0._txtexpire.text = luaLang("hasExpire")
		else
			local var_42_1 = math.floor(var_42_0 - ServerTime.now())

			arg_42_0._txtproptip.text = arg_42_0:getRemainTimeStr(var_42_1)
		end
	else
		local var_42_2 = ItemConfig.instance:getInsightItemCo(arg_42_0.viewParam.id).expireHours

		arg_42_0._txtproptip.text = arg_42_0:getInsightItemRemainTimeStr(var_42_2)
		arg_42_0._txtexpire.text = ""

		TaskDispatcher.cancelTask(arg_42_0._onRefreshNewInsightDeadline, arg_42_0)
	end
end

function var_0_0.getRemainTimeStr(arg_43_0, arg_43_1)
	local var_43_0 = TimeUtil.getFormatTime(arg_43_1)

	return var_43_0 and var_0_2(luaLang("remain"), " " .. var_43_0) or ""
end

function var_0_0.getInsightItemRemainTimeStr(arg_44_0, arg_44_1)
	local var_44_0 = TimeUtil.secondToRoughTime2(arg_44_1 * 3600, false)

	return var_44_0 and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("newinsight_item_detail_remain_time"), var_44_0) or ""
end

function var_0_0._onRefreshItemDeadline(arg_45_0)
	if arg_45_0._config.isShow == 1 and arg_45_0._config.isTimeShow == 1 and arg_45_0._config.expireTime and arg_45_0._config.expireTime ~= "" then
		local var_45_0 = TimeUtil.stringToTimestamp(arg_45_0._config.expireTime)

		if var_45_0 <= ServerTime.now() then
			arg_45_0._txtproptip.text = ""
			arg_45_0._txtexpire.text = luaLang("hasExpire")
		else
			local var_45_1 = math.floor(var_45_0 - ServerTime.now())

			arg_45_0._txtproptip.text = arg_45_0:getRemainTimeStr(var_45_1)
		end
	else
		arg_45_0._txtproptip.text = ""
		arg_45_0._txtexpire.text = ""

		TaskDispatcher.cancelTask(arg_45_0._onRefreshItemDeadline, arg_45_0)
	end
end

function var_0_0._onLoadCallback(arg_46_0)
	local var_46_0 = arg_46_0._loader:getFirstAssetItem():GetResource()

	gohelper.clone(var_46_0, arg_46_0._goframenode, "frame")
end

function var_0_0._refreshItemQuantity(arg_47_0)
	local var_47_0 = tostring(GameUtil.numberDisplay(ItemModel.instance:getItemQuantity(arg_47_0.viewParam.type, arg_47_0.viewParam.id, arg_47_0.viewParam.uid, arg_47_0.viewParam.fakeQuantity)) or 0)

	arg_47_0._txthadnumber.text = formatLuaLang("materialtipview_itemquantity", var_47_0)
end

function var_0_0._refreshItemQuantityVisible(arg_48_0)
	local var_48_0 = arg_48_0.viewParam.id ~= BpEnum.ScoreItemId
	local var_48_1 = arg_48_0.viewParam.type == MaterialEnum.MaterialType.Exp

	gohelper.setActive(arg_48_0._gohadnumber, var_48_0 and not var_48_1)
	gohelper.setActive(arg_48_0._txthadnumber, var_48_0)
end

function var_0_0._setIconNativeSize(arg_49_0)
	arg_49_0._simagepropicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
end

function var_0_0._refreshInclude(arg_50_0)
	local var_50_0 = MaterialEnum.SubTypePackages[arg_50_0._config.subType] == true

	var_50_0 = var_50_0 or arg_50_0:_isPackageSkin()
	var_50_0 = var_50_0 and arg_50_0.viewParam.inpack ~= true

	if arg_50_0._config.subType == ItemEnum.SubType.SelfSelectSix then
		var_50_0 = true
	end

	gohelper.setActive(arg_50_0._goinclude, var_50_0)

	local var_50_1 = 0
	local var_50_2

	if var_50_0 then
		local var_50_3

		if arg_50_0:_isPackageSkin() then
			var_50_3 = arg_50_0:_getPackageSkinIncludeItems()
		elseif arg_50_0._config.subType == ItemEnum.SubType.OptionalGift then
			var_50_3 = GiftMultipleChoiceListModel.instance:getOptionalGiftInfo(arg_50_0._config.id)
		elseif arg_50_0._config.subType == ItemEnum.SubType.OptionalHeroGift then
			var_50_3 = {}

			local var_50_4 = string.splitToNumber(arg_50_0._config.effect, "#")

			for iter_50_0, iter_50_1 in ipairs(var_50_4) do
				var_50_3[iter_50_0] = {
					4,
					iter_50_1,
					1
				}
			end
		elseif arg_50_0._config.subType == ItemEnum.SubType.SelfSelectSix then
			local var_50_5 = string.split(arg_50_0._config.effect, "|")

			var_50_3 = {}

			for iter_50_2, iter_50_3 in ipairs(var_50_5) do
				local var_50_6 = string.split(iter_50_3, ":")
				local var_50_7 = {}

				if var_50_6[2] and #var_50_6[2] > 0 then
					local var_50_8 = string.splitToNumber(var_50_6[2], ",")

					if #var_50_8 > 0 then
						for iter_50_4, iter_50_5 in ipairs(var_50_8) do
							local var_50_9 = {
								MaterialEnum.MaterialType.Hero,
								iter_50_5
							}

							var_50_9[3] = 1

							table.insert(var_50_3, var_50_9)
						end
					end
				end
			end
		else
			var_50_3 = GameUtil.splitString2(arg_50_0._config.effect, true)
		end

		var_50_1 = #var_50_3

		for iter_50_6, iter_50_7 in ipairs(var_50_3) do
			local var_50_10 = arg_50_0._iconItemList[iter_50_6]

			if var_50_10 == nil then
				local var_50_11 = iter_50_7[1]
				local var_50_12 = iter_50_7[2]
				local var_50_13 = iter_50_7[3]

				var_50_2 = var_50_11

				if var_50_11 == MaterialEnum.MaterialType.Equip then
					var_50_10 = IconMgr.instance:getCommonEquipIcon(arg_50_0._goincludeContent)

					var_50_10:setMOValue(var_50_11, var_50_12, var_50_13, nil, true)
					var_50_10:hideLv(true)

					local function var_50_14()
						MaterialTipController.instance:showMaterialInfo(var_50_11, var_50_12)
					end

					var_50_10:customClick(var_50_14)
				elseif var_50_11 == MaterialEnum.MaterialType.Hero then
					var_50_10 = IconMgr.instance:getCommonItemIcon(arg_50_0._goincludeContent)

					var_50_10:setMOValue(var_50_11, var_50_12, var_50_13, nil, true)
					var_50_10:isShowCount(false)
				elseif var_50_11 == MaterialEnum.MaterialType.HeroSkin then
					var_50_10 = IconMgr.instance:getCommonItemIcon(arg_50_0._goincludeContent)

					var_50_10:setMOValue(var_50_11, var_50_12, var_50_13, nil, true)
					var_50_10:isShowCount(false)
				else
					var_50_10 = IconMgr.instance:getCommonItemIcon(arg_50_0._goincludeContent)

					var_50_10:setMOValue(var_50_11, var_50_12, var_50_13, nil, true)
					var_50_10:isShowCount(true)
				end

				table.insert(arg_50_0._iconItemList, var_50_10)
			end

			var_50_10:setCountFontSize(37.142857142857146)
			gohelper.setActive(var_50_10.go, true)
		end
	end

	if var_50_2 == MaterialEnum.MaterialType.Equip then
		arg_50_0._contentHorizontal.spacing = 6.62
		arg_50_0._contentHorizontal.padding.left = -2
		arg_50_0._contentHorizontal.padding.top = 10
	end

	for iter_50_8 = var_50_1 + 1, #arg_50_0._iconItemList do
		gohelper.setActive(arg_50_0._iconItemList[iter_50_8].go, false)
	end
end

function var_0_0._isUseBtnShow(arg_52_0)
	local var_52_0 = ItemConfig.instance:getItemUseCo(arg_52_0._config.subType)
	local var_52_1 = arg_52_0.viewParam.inpack and var_52_0 and var_52_0.useType ~= 1

	if arg_52_0.viewParam.type == MaterialEnum.MaterialType.PowerPotion and arg_52_0.viewParam.inpack and arg_52_0:_isFromBackpackView() then
		return true
	end

	if arg_52_0.viewParam.type == MaterialEnum.MaterialType.NewInsight and arg_52_0.viewParam.inpack and arg_52_0:_isFromBackpackView() then
		return true
	end

	if arg_52_0._config.subType == ItemEnum.SubType.RoomTicket then
		if ViewMgr.instance:isOpen(ViewName.StoreView) then
			return false
		end

		return var_52_1
	end

	if arg_52_0._config.subType == ItemEnum.SubType.SkinTicket then
		if ViewMgr.instance:isOpen(ViewName.StoreView) then
			return false
		end

		return ItemModel.instance:getItemQuantity(arg_52_0.viewParam.type, arg_52_0.viewParam.id, arg_52_0.viewParam.uid, arg_52_0.viewParam.fakeQuantity) > 0
	end

	if arg_52_0._config.subType == ItemEnum.SubType.DecorateDiscountTicket then
		if ViewMgr.instance:isOpen(ViewName.StoreView) then
			return false
		end

		return ItemModel.instance:getItemQuantity(arg_52_0.viewParam.type, arg_52_0.viewParam.id, arg_52_0.viewParam.uid, arg_52_0.viewParam.fakeQuantity) > 0
	end

	return var_52_1
end

function var_0_0._isFromBackpackView(arg_53_0)
	local var_53_0 = ViewMgr.instance:getOpenViewNameList()

	for iter_53_0, iter_53_1 in pairs(var_53_0) do
		if iter_53_1 == ViewName.BackpackView then
			return true
		end
	end

	return false
end

function var_0_0.statJump(arg_54_0, arg_54_1)
	local var_54_0 = arg_54_0.viewParam.id == MaterialEnum.PowerId.SmallPower_Expire
	local var_54_1 = arg_54_0.viewParam.id == MaterialEnum.PowerId.BigPower_Expire

	if var_54_0 or var_54_1 then
		local var_54_2

		if arg_54_1 then
			var_54_2 = JumpConfig.instance:getJumpConfig(arg_54_1)
		end

		if var_54_0 then
			StoreController.instance:statOnClickPowerPotionJump(StatEnum.PowerType.Small, var_54_2.name)
		elseif var_54_1 then
			StoreController.instance:statOnClickPowerPotionJump(StatEnum.PowerType.Big, var_54_2.name)
		end
	end
end

function var_0_0.onClose(arg_55_0)
	TaskDispatcher.cancelTask(arg_55_0._onRefreshPowerPotionDeadline, arg_55_0)
	TaskDispatcher.cancelTask(arg_55_0._onRefreshNewInsightDeadline, arg_55_0)
	TaskDispatcher.cancelTask(arg_55_0._onRefreshItemDeadline, arg_55_0)

	arg_55_0.viewContainer._isCloseImmediate = true

	for iter_55_0 = 1, #arg_55_0.jumpItemGos do
		arg_55_0.jumpItemGos[iter_55_0].jumpBtn:RemoveClickListener()
	end

	for iter_55_1 = 1, #arg_55_0._boxItemGos do
		arg_55_0._boxItemGos[iter_55_1].jumpBtn:RemoveClickListener()
	end

	if arg_55_0._loader then
		arg_55_0._loader:dispose()

		arg_55_0._loader = nil
	end

	arg_55_0._simagepropicon:UnLoadImage()
	arg_55_0._simageheadicon:UnLoadImage()
	arg_55_0._simageequipicon:UnLoadImage()
	arg_55_0._simagebg1:UnLoadImage()
	arg_55_0._simagebg2:UnLoadImage()
end

function var_0_0._isPackageSkin(arg_56_0)
	return arg_56_0._config.clienttag == ItemEnum.Tag.PackageSkin
end

function var_0_0._getPackageSkinDesc(arg_57_0)
	local var_57_0 = ItemConfig.instance:getRewardGroupRateInfoList(arg_57_0._config.effect)
	local var_57_1 = {}

	for iter_57_0, iter_57_1 in ipairs(var_57_0) do
		local var_57_2 = iter_57_1.rate * 100
		local var_57_3 = var_0_1(var_57_2)
		local var_57_4 = var_57_2 - var_57_3

		if var_57_4 ~= 0 then
			local var_57_5 = var_0_1(var_57_4 * 1000 / 100)

			var_57_2 = var_0_2("%s.%s", var_57_3, var_57_5)
		end

		local var_57_6 = iter_57_1.materialId
		local var_57_7 = lua_skin.configDict[var_57_6]
		local var_57_8 = var_57_7.characterId
		local var_57_9 = lua_character.configDict[var_57_8]
		local var_57_10 = {
			var_57_9.name,
			var_57_7.characterSkin,
			var_57_2
		}
		local var_57_11 = GameUtil.getSubPlaceholderLuaLang(luaLang("material_packageskin_rate_desc"), var_57_10)

		var_0_3(var_57_1, var_57_11)
	end

	return formatLuaLang("MaterialTipViewPackageSkinDescFmt", table.concat(var_57_1, "\n"))
end

function var_0_0._getPackageSkinIncludeItems(arg_58_0)
	local var_58_0 = ItemConfig.instance:getRewardGroupRateInfoList(arg_58_0._config.effect)
	local var_58_1 = {}

	for iter_58_0, iter_58_1 in ipairs(var_58_0) do
		var_0_3(var_58_1, {
			iter_58_1.materialType,
			iter_58_1.materialId,
			[3] = 1
		})
	end

	return var_58_1
end

function var_0_0._isSummonSkin(arg_59_0)
	return arg_59_0._config.clienttag == ItemEnum.Tag.SummonSkin
end

return var_0_0
