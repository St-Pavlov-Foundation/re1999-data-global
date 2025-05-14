module("modules.logic.character.view.CharacterTalentChessView", package.seeall)

local var_0_0 = class("CharacterTalentChessView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._goblock = gohelper.findChild(arg_1_0.viewGO, "#go_block")
	arg_1_0._gochessContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_chessContainer")
	arg_1_0._gomeshContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_meshContainer")
	arg_1_0._gomeshItem = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_meshContainer/#go_meshItem")
	arg_1_0._godragAnchor = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_dragAnchor")
	arg_1_0._godragContainer = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_dragAnchor/#go_dragContainer")
	arg_1_0._gocellModel = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_dragAnchor/#go_cellModel")
	arg_1_0._gochessitem = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_chessitem")
	arg_1_0._goraychessitem = gohelper.findChild(arg_1_0.viewGO, "chessboard/#go_raychessitem")
	arg_1_0._btnroleAttribute = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_roleAttribute")
	arg_1_0._txttalentcn = gohelper.findChildText(arg_1_0.viewGO, "#btn_roleAttribute/#txt_talentcn")
	arg_1_0._txttalentEn = gohelper.findChildText(arg_1_0.viewGO, "#btn_roleAttribute/txtEn")
	arg_1_0._scrollinspiration = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_inspiration")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_inspiration/Viewport/#go_Content")
	arg_1_0._goinspirationItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_inspiration/Viewport/#go_Content/#go_inspirationItem")
	arg_1_0._goEmpty = gohelper.findChild(arg_1_0.viewGO, "#scroll_inspiration/Empty")
	arg_1_0._gotip = gohelper.findChild(arg_1_0.viewGO, "#go_tip")
	arg_1_0._gosingleTipsContent = gohelper.findChild(arg_1_0.viewGO, "#go_tip/attributetip/#go_singleTipsContent")
	arg_1_0._gosingleAttributeItem = gohelper.findChild(arg_1_0.viewGO, "#go_tip/attributetip/#go_singleTipsContent/#go_singleAttributeItem")
	arg_1_0._btnclosetipArea = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/#btn_closetipArea")
	arg_1_0._btntakeoffallcube = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_removeAll")
	arg_1_0._btnrecommend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_recommend")
	arg_1_0._goupdatetips = gohelper.findChild(arg_1_0.viewGO, "#go_updatetips")
	arg_1_0._goupdatetipscontent = gohelper.findChild(arg_1_0.viewGO, "#go_updatetips/attributetip/#go_updateTipsContent")
	arg_1_0._goupdateattributeitem = gohelper.findChild(arg_1_0.viewGO, "#go_updatetips/attributetip/#go_updateTipsContent/#go_updateAttributeItem")
	arg_1_0._dropresonategroup = gohelper.findChildDropdown(arg_1_0.viewGO, "#drop_resonategroup")
	arg_1_0._txtgroupname = gohelper.findChildText(arg_1_0.viewGO, "#drop_resonategroup/txt_groupname")
	arg_1_0._btnchangetemplatename = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "#drop_resonategroup/#btn_changetemplatename")
	arg_1_0._dropClick = gohelper.getClick(arg_1_0._dropresonategroup.gameObject)
	arg_1_0._gostylechange = gohelper.findChild(arg_1_0.viewGO, "#go_stylechange")
	arg_1_0._txtlabel = gohelper.findChildText(arg_1_0.viewGO, "#go_stylechange/#txt_label")
	arg_1_0._btnstylechange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_stylechange/#btn_check")
	arg_1_0._goMaxLevel = gohelper.findChild(arg_1_0.viewGO, "#go_check")
	arg_1_0._btnMaxLevel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_check/#btn_check")
	arg_1_0._styleslot = gohelper.findChildImage(arg_1_0.viewGO, "#go_stylechange/slot")
	arg_1_0._styleicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_stylechange/slot/icon")
	arg_1_0._styleglow = gohelper.findChildImage(arg_1_0.viewGO, "#go_stylechange/slot/glow")
	arg_1_0._styleupdate = gohelper.findChild(arg_1_0.viewGO, "#go_stylechange/update")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnchangetemplatename:AddClickListener(arg_2_0._onBtnChangeTemplateName, arg_2_0)
	arg_2_0._btnroleAttribute:AddClickListener(arg_2_0._btnroleAttributeOnClick, arg_2_0)
	arg_2_0._btnclosetipArea:AddClickListener(arg_2_0._btnCloseTipOnClick, arg_2_0)
	arg_2_0._btntakeoffallcube:AddClickListener(arg_2_0._onBtnTakeOffAllCube, arg_2_0)
	arg_2_0._btnrecommend:AddClickListener(arg_2_0._showQuickLayoutPanel, arg_2_0)
	arg_2_0._dropresonategroup:AddOnValueChanged(arg_2_0._opDropdownChange, arg_2_0)
	arg_2_0._dropClick:AddClickListener(arg_2_0._onDropClick, arg_2_0)
	arg_2_0._btnstylechange:AddClickListener(arg_2_0._onStyleChangeClick, arg_2_0)
	arg_2_0._btnMaxLevel:AddClickListener(arg_2_0._onMaxLevelClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnchangetemplatename:RemoveClickListener()
	arg_3_0._btnroleAttribute:RemoveClickListener()
	arg_3_0._btnclosetipArea:RemoveClickListener()
	arg_3_0._btntakeoffallcube:RemoveClickListener()
	arg_3_0._btnrecommend:RemoveClickListener()
	arg_3_0._dropresonategroup:RemoveOnValueChanged()
	arg_3_0._dropClick:RemoveClickListener()
	arg_3_0._btnstylechange:RemoveClickListener()
	arg_3_0._btnMaxLevel:RemoveClickListener()
end

function var_0_0._btnroleAttributeOnClick(arg_4_0)
	CharacterController.instance:openCharacterTalentTipView({
		open_type = 0,
		hero_id = arg_4_0.hero_id
	})
end

function var_0_0._onBtnTakeOffAllCube(arg_5_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.TakeOffAllTalentCube, MsgBoxEnum.BoxType.Yes_No, function()
		arg_5_0:_releaseDragItem()
		HeroRpc.instance:TakeoffAllTalentCubeRequest(arg_5_0.hero_id)
	end)
end

function var_0_0._btnCloseTipOnClick(arg_7_0)
	local var_7_0 = arg_7_0.cur_select_cell_data

	if var_7_0 then
		local var_7_1 = gohelper.findChild(arg_7_0._gochessContainer, string.format("%s_%s_%s_%s", var_7_0.cubeId, var_7_0.direction, var_7_0.posX, var_7_0.posY))

		if var_7_1 then
			local var_7_2 = var_7_1.transform
			local var_7_3 = 1.35

			transformhelper.setLocalScale(var_7_2, var_7_3, var_7_3, var_7_3)
			gohelper.setActive(var_7_2:Find("icon").gameObject, false)
		end
	end

	arg_7_0.cur_select_cell_data = nil

	gohelper.setActive(arg_7_0._gotip, false)

	if arg_7_0._quickLayoutPanel and arg_7_0._quickLayoutPanel.gameObject.activeSelf then
		arg_7_0:_hideQuickLayoutPanel()
	end
end

function var_0_0._editableInitView(arg_8_0)
	gohelper.addChild(arg_8_0.viewGO, arg_8_0._goinspirationItem)
	gohelper.setActive(arg_8_0._goinspirationItem, false)

	arg_8_0._goinspirationItemItem = arg_8_0._goinspirationItem.transform:Find("attributeContent/attributeItem").gameObject
	arg_8_0.bg_ani = gohelper.findChildComponent(arg_8_0.viewGO, "", typeof(UnityEngine.Animator))
	arg_8_0.go_yanwu = gohelper.findChild(arg_8_0.viewGO, "chessboard/yanwu")
	arg_8_0._txtgroupname.text = luaLang("p_charactertalentchessview_txt_groupname")

	gohelper.addUIClickAudio(arg_8_0._btnroleAttribute.gameObject, AudioEnum.UI.play_ui_admission_open)
	gohelper.addUIClickAudio(arg_8_0._btntakeoffallcube.gameObject, AudioEnum.UI.Play_UI_Universal_Click)

	arg_8_0._gomaxselect = gohelper.findChild(arg_8_0.viewGO, "#go_check/#btn_check/selected")
	arg_8_0._gomaxunselect = gohelper.findChild(arg_8_0.viewGO, "#go_check/#btn_check/unselect")
	arg_8_0._leftContentAnim = arg_8_0._goContent:GetComponent(typeof(UnityEngine.Animator))
	arg_8_0._quickLayoutIcon = gohelper.findChild(arg_8_0.viewGO, "#btn_recommend/cn/image_Arrow")

	arg_8_0:addEventCb(CharacterController.instance, CharacterEvent.RefreshCubeList, arg_8_0._onRefreshCubeList, arg_8_0)
	arg_8_0:addEventCb(CharacterController.instance, CharacterEvent.ClickFirstResonanceCellItem, arg_8_0._clickFirstResonanceCellItem, arg_8_0)
	arg_8_0:addEventCb(CharacterController.instance, CharacterEvent.ShowGuideDragEffect, arg_8_0._showGuideDragEffect, arg_8_0)
	arg_8_0:addEventCb(CharacterController.instance, CharacterEvent.CopyTalentData, arg_8_0._onCopyTalentData, arg_8_0)
	arg_8_0:addEventCb(CharacterController.instance, CharacterEvent.UseTalentTemplateReply, arg_8_0._onUseTalentTemplateReply, arg_8_0)
	arg_8_0:addEventCb(CharacterController.instance, CharacterEvent.RenameTalentTemplateReply, arg_8_0._onRenameTalentTemplateReply, arg_8_0)
	arg_8_0:addEventCb(CharacterController.instance, CharacterEvent.onUseTalentStyleReply, arg_8_0._onUseTalentStyleReply, arg_8_0)
	arg_8_0:addEventCb(HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, arg_8_0._onUseShareCode, arg_8_0)
end

function var_0_0._showGuideDragEffect(arg_9_0, arg_9_1)
	if arg_9_0._dragEffectLoader then
		arg_9_0._dragEffectLoader:dispose()

		arg_9_0._dragEffectLoader = nil
	end

	local var_9_0 = tonumber(arg_9_1) == 1

	gohelper.setActive(arg_9_0._goblock, var_9_0)

	if var_9_0 then
		arg_9_0._dragEffectLoader = PrefabInstantiate.Create(arg_9_0.viewGO)

		arg_9_0._dragEffectLoader:startLoad("ui/viewres/guide/guide_character.prefab", arg_9_0._onDragEffectLoaded, arg_9_0)
	end
end

function var_0_0._onDragEffectLoaded(arg_10_0)
	local var_10_0 = arg_10_0.own_cube_list[1]
	local var_10_1 = HeroResonanceConfig.instance:getCubeConfig(var_10_0.id)
	local var_10_2 = #(var_10_1.shape and string.split(var_10_1.shape, "#") or {})
	local var_10_3 = arg_10_0._dragEffectLoader:getInstGO()

	gohelper.setActive(gohelper.findChild(var_10_3, "guide1").gameObject, var_10_2 <= 2)
	gohelper.setActive(gohelper.findChild(var_10_3, "guide2").gameObject, var_10_2 >= 3)
end

function var_0_0._clickFirstResonanceCellItem(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0._rabbet_cell_list) do
		if iter_11_1.is_filled then
			iter_11_1:clickCube()

			break
		end
	end
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	gohelper.setActive(arg_13_0._gotip, false)
	gohelper.setActive(arg_13_0._godragContainer, false)

	arg_13_0.cell_length = 76.2
	arg_13_0.half_length = 38.1

	if type(arg_13_0.viewParam) == "table" then
		arg_13_0.hero_id = arg_13_0.viewParam.hero_id

		if arg_13_0.viewParam.aniPlayIn2 then
			arg_13_0.viewGO:GetComponent(typeof(UnityEngine.Animator)):Play("charactertalentchess_in2", 0, 0)
		end
	else
		arg_13_0.hero_id = arg_13_0.viewParam
	end

	arg_13_0.hero_mo_data = HeroModel.instance:getByHeroId(arg_13_0.hero_id)
	arg_13_0._mainCubeId = arg_13_0.hero_mo_data.talentCubeInfos.own_main_cube_id
	arg_13_0._canPlayCubeAnim = false
	arg_13_0._mainCubeItem = nil

	if not arg_13_0.hero_mo_data then
		print("打印我所拥有的英雄~~~~~~~~~~~~~")

		for iter_13_0, iter_13_1 in pairs(HeroModel.instance._heroId2MODict) do
			print("英雄id：" .. iter_13_1.heroId)
		end

		error("找不到英雄数据~~~~~~~~~~~~~~~~id:" .. arg_13_0.hero_id)

		return
	end

	arg_13_0:_setChessboardData()
	arg_13_0:_setDebrisData()
	TaskDispatcher.runDelay(arg_13_0._playScrollTween, arg_13_0, 0.3)

	arg_13_0._last_add_attr = arg_13_0.hero_mo_data:getTalentGain()

	arg_13_0:_initTemplateList()

	arg_13_0._txttalentcn.text = luaLang("talent_charactertalentlevelup_leveltxt" .. CharacterEnum.TalentTxtByHeroType[arg_13_0.hero_mo_data.config.heroType])
	arg_13_0._txttalentEn.text = luaLang("talent_charactertalentchess_staten" .. CharacterEnum.TalentTxtByHeroType[arg_13_0.hero_mo_data.config.heroType])

	arg_13_0:_refreshStyleTag()

	arg_13_0._showMaxLVBtn = true

	arg_13_0:_showMaxLvBtn()
	arg_13_0:_hideStyleUpdateAnim()
	arg_13_0:_initQuickLayoutItem()
end

function var_0_0._playScrollTween(arg_14_0)
	arg_14_0._isPlayScrollTween = true

	if arg_14_0.own_cube_list then
		if not arg_14_0.cubeItemList then
			arg_14_0.cubeItemList = arg_14_0:getUserDataTb_()
		end

		arg_14_0._goContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = false
		arg_14_0._goContent:GetComponent(gohelper.Type_VerticalLayoutGroup).enabled = false
		arg_14_0.parallel_sequence = arg_14_0.parallel_sequence or FlowParallel.New()

		for iter_14_0, iter_14_1 in ipairs(arg_14_0.own_cube_list) do
			local var_14_0 = arg_14_0._goContent.transform:GetChild(iter_14_0 - 1)
			local var_14_1 = recthelper.getAnchorY(var_14_0)

			recthelper.setAnchorY(var_14_0, var_14_1 - 200)

			local var_14_2 = FlowSequence.New()

			var_14_2:addWork(WorkWaitSeconds.New(0.03 * (iter_14_0 - 1)))

			local var_14_3 = FlowParallel.New()

			var_14_3:addWork(TweenWork.New({
				type = "DOAnchorPosY",
				t = 0.35,
				tr = var_14_0,
				to = var_14_1,
				ease = EaseType.OutCubic
			}))
			var_14_3:addWork(TweenWork.New({
				from = 0,
				type = "DOFadeCanvasGroup",
				to = 1,
				t = 0.6,
				go = var_14_0.gameObject
			}))
			var_14_2:addWork(var_14_3)

			if iter_14_0 == #arg_14_0.own_cube_list then
				var_14_2:addWork(FunctionWork.New(function()
					arg_14_0._goContent:GetComponent(gohelper.Type_VerticalLayoutGroup).enabled = true
					arg_14_0._goContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = true
					arg_14_0._isPlayScrollTween = nil
				end))
			end

			arg_14_0.parallel_sequence:addWork(var_14_2)

			local var_14_4 = var_14_0:GetComponent(typeof(UnityEngine.CanvasGroup))
			local var_14_5 = arg_14_0:getUserDataTb_()

			var_14_5.tr = var_14_0
			var_14_5.cangroup = var_14_4
			var_14_5.anchorY = var_14_1

			table.insert(arg_14_0.cubeItemList, var_14_5)
		end

		arg_14_0.parallel_sequence:start({})
	end
end

function var_0_0._onRefreshCubeList(arg_16_0)
	if arg_16_0.ignore_refresh_list then
		arg_16_0.ignore_refresh_list = nil

		return
	end

	arg_16_0._goinspirationItem:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1

	arg_16_0:_setChessboardData()
	arg_16_0:_setDebrisData()

	if arg_16_0.drag_data then
		arg_16_0:_detectDragResult()
	end

	if arg_16_0._last_add_attr then
		local var_16_0 = {}
		local var_16_1 = arg_16_0.hero_mo_data:getTalentGain()

		for iter_16_0, iter_16_1 in pairs(var_16_1) do
			if arg_16_0._last_add_attr[iter_16_1.key] then
				local var_16_2 = iter_16_1.value
				local var_16_3 = arg_16_0._last_add_attr[iter_16_1.key].value
				local var_16_4 = var_16_2 - var_16_3

				if var_16_4 > 0 then
					if HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(iter_16_1.key)).type == 1 then
						var_16_4 = math.floor(var_16_2) - math.floor(var_16_3)
					end

					if var_16_4 > 0 then
						table.insert(var_16_0, {
							key = iter_16_1.key,
							value = var_16_4
						})
					end
				end
			else
				table.insert(var_16_0, {
					key = iter_16_1.key,
					value = iter_16_1.value
				})
			end
		end

		arg_16_0:_showAttrTip(var_16_0)

		arg_16_0._last_add_attr = var_16_1
	end
end

function var_0_0._showAttrTip(arg_17_0, arg_17_1)
	table.sort(arg_17_1, function(arg_18_0, arg_18_1)
		return HeroConfig.instance:getIDByAttrType(arg_18_0.key) < HeroConfig.instance:getIDByAttrType(arg_18_1.key)
	end)
	gohelper.CreateObjList(arg_17_0, arg_17_0._showUpdateAttributeTips, arg_17_1, arg_17_0._goupdatetipscontent, arg_17_0._goupdateattributeitem)
	gohelper.setActive(arg_17_0._goupdatetips, true)

	arg_17_0._update_attr_tips_ani = arg_17_0._update_attr_tips_ani or FlowParallel.New()

	arg_17_0._update_attr_tips_ani:destroy()
	arg_17_0._update_attr_tips_ani:ctor()

	local var_17_0 = #arg_17_1

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		local var_17_1 = arg_17_0._goupdatetipscontent.transform:GetChild(iter_17_0 - 1)
		local var_17_2 = FlowSequence.New()

		var_17_2:addWork(WorkWaitSeconds.New(0.06 * (iter_17_0 - 1)))
		var_17_2:addWork(FunctionWork.New(function()
			gohelper.setActive(var_17_1.gameObject, true)
		end))
		var_17_2:addWork(TweenWork.New({
			from = 0,
			type = "DOFadeCanvasGroup",
			to = 1,
			t = 0.2,
			go = var_17_1.gameObject
		}))
		var_17_2:addWork(WorkWaitSeconds.New(1))
		var_17_2:addWork(TweenWork.New({
			from = 1,
			type = "DOFadeCanvasGroup",
			to = 0,
			t = 0.2,
			go = var_17_1.gameObject
		}))

		if iter_17_0 == var_17_0 then
			var_17_2:addWork(FunctionWork.New(function()
				gohelper.setActive(arg_17_0._goupdatetips, false)
			end))
		end

		arg_17_0._update_attr_tips_ani:addWork(var_17_2)
	end

	arg_17_0._update_attr_tips_ani:start({})
end

function var_0_0._showUpdateAttributeTips(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = arg_21_1.transform
	local var_21_1 = var_21_0:Find("iconroot/icon"):GetComponent(gohelper.Type_Image)
	local var_21_2 = var_21_0:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local var_21_3 = var_21_0:Find("num"):GetComponent(gohelper.Type_TextMesh)
	local var_21_4 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(arg_21_2.key))

	if var_21_4.type ~= 1 then
		arg_21_2.value = "+" .. tonumber(string.format("%.3f", arg_21_2.value / 10)) .. "%"
	else
		arg_21_2.value = "+" .. math.floor(arg_21_2.value)
	end

	var_21_3.text = arg_21_2.value
	var_21_2.text = var_21_4.name

	UISpriteSetMgr.instance:setCommonSprite(var_21_1, "icon_att_" .. var_21_4.id, true)
	gohelper.setActive(arg_21_1, false)
end

function var_0_0.getRabbetCell(arg_22_0)
	return arg_22_0._rabbet_cell
end

function var_0_0._setChessboardData(arg_23_0)
	local var_23_0 = string.splitToNumber(HeroResonanceConfig.instance:getTalentAllShape(arg_23_0.hero_mo_data.heroId, arg_23_0.hero_mo_data.talent), ",")

	if arg_23_0.last_talent_level ~= arg_23_0.hero_mo_data.talent then
		arg_23_0:_releaseCellList()

		arg_23_0._rabbet_cell = {}
		arg_23_0._rabbet_cell_list = {}

		local var_23_1 = 0

		for iter_23_0 = 0, var_23_0[2] - 1 do
			arg_23_0._rabbet_cell[iter_23_0] = {}

			for iter_23_1 = 0, var_23_0[1] - 1 do
				local var_23_2

				if var_23_1 < arg_23_0._gomeshContainer.transform.childCount then
					var_23_2 = arg_23_0._gomeshContainer.transform:GetChild(var_23_1)
				else
					var_23_2 = gohelper.clone(arg_23_0._gomeshItem, arg_23_0._gomeshContainer)
				end

				local var_23_3 = iter_23_1 - (var_23_0[1] - 1) / 2
				local var_23_4 = (var_23_0[2] - 1) / 2 - iter_23_0

				recthelper.setAnchor(var_23_2.transform, var_23_3 * arg_23_0.cell_length, var_23_4 * arg_23_0.cell_length)

				arg_23_0._rabbet_cell[iter_23_0][iter_23_1] = ResonanceCellItem.New(var_23_2.gameObject, iter_23_1, iter_23_0, arg_23_0)

				table.insert(arg_23_0._rabbet_cell_list, arg_23_0._rabbet_cell[iter_23_0][iter_23_1])

				var_23_1 = var_23_1 + 1
			end
		end
	end

	arg_23_0.last_talent_level = arg_23_0.hero_mo_data.talent

	for iter_23_2, iter_23_3 in ipairs(arg_23_0._rabbet_cell_list) do
		iter_23_3.is_filled = false
		iter_23_3.cell_data = nil
	end

	arg_23_0.cube_data = arg_23_0.hero_mo_data.talentCubeInfos.data_list

	arg_23_0:_checkMainCubeNil()
	gohelper.CreateObjList(arg_23_0, arg_23_0._onCubeItemShow, arg_23_0.cube_data, arg_23_0._gochessContainer, arg_23_0._gochessitem)
	arg_23_0:RefreshAllCellLine(true)

	if arg_23_0.effect_showed then
		arg_23_0.effect_showed = nil
		arg_23_0.put_cube_ani = nil
	end

	arg_23_0:_checkAttenuation()
end

function var_0_0._checkMainCubeNil(arg_24_0)
	if arg_24_0.cube_data then
		for iter_24_0, iter_24_1 in pairs(arg_24_0.cube_data) do
			if iter_24_1.cubeId == arg_24_0._mainCubeId then
				return
			end
		end
	end

	arg_24_0._mainCubeItem = nil
end

function var_0_0._checkAttenuation(arg_25_0)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in ipairs(arg_25_0.cube_data) do
		local var_25_1 = var_25_0[iter_25_1.cubeId] or 0

		var_25_0[iter_25_1.cubeId] = var_25_1 + 1
	end

	for iter_25_2, iter_25_3 in pairs(var_25_0) do
		if iter_25_3 >= 4 then
			CharacterController.instance:dispatchEvent(CharacterEvent.OnGuideAttenuation)

			return
		end
	end
end

function var_0_0.playChessIconOutAni(arg_26_0)
	if arg_26_0.cube_data then
		for iter_26_0, iter_26_1 in ipairs(arg_26_0.cube_data) do
			arg_26_0._gochessContainer.transform:GetChild(iter_26_0 - 1):GetComponent(typeof(UnityEngine.Animator)):Play("chessitem_out")
		end
	end
end

function var_0_0.RefreshAllCellLine(arg_27_0, arg_27_1)
	if arg_27_0._rabbet_cell_list then
		for iter_27_0, iter_27_1 in ipairs(arg_27_0._rabbet_cell_list) do
			iter_27_1:SetNormal(arg_27_1)
		end
	end
end

function var_0_0.setChessCubeIconAlpha(arg_28_0, arg_28_1)
	if arg_28_0.cube_data then
		for iter_28_0, iter_28_1 in ipairs(arg_28_0.cube_data) do
			local var_28_0 = arg_28_0._gochessContainer.transform:GetChild(iter_28_0 - 1):GetComponent(typeof(UnityEngine.CanvasGroup))

			if not arg_28_1 then
				var_28_0.alpha = 1
			elseif iter_28_1 == arg_28_1 then
				var_28_0.alpha = 0.5
			end
		end
	end
end

function var_0_0._onCubeItemShow(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_1.transform

	arg_29_1.name = string.format("%s_%s_%s_%s", arg_29_2.cubeId, arg_29_2.direction, arg_29_2.posX, arg_29_2.posY)

	local var_29_1 = var_29_0:GetComponent(gohelper.Type_Image)
	local var_29_2 = gohelper.findChildImage(arg_29_1, "icon")
	local var_29_3 = gohelper.findChildImage(arg_29_1, "glow")
	local var_29_4 = gohelper.findChildImage(arg_29_1, "cell")
	local var_29_5 = arg_29_1:GetComponent(typeof(UnityEngine.Animator))
	local var_29_6 = HeroResonanceConfig.instance:getCubeMatrix(arg_29_2.cubeId)
	local var_29_7 = arg_29_0:_rotationMatrix(var_29_6, arg_29_2.direction)
	local var_29_8 = arg_29_0._mainCubeId == arg_29_2.cubeId

	if arg_29_0.cur_select_cell_data then
		if arg_29_0.cur_select_cell_data.cubeId == arg_29_2.cubeId and arg_29_0.cur_select_cell_data.direction == arg_29_2.direction and arg_29_0.cur_select_cell_data.posX == arg_29_2.posX and arg_29_0.cur_select_cell_data.posY == arg_29_2.posY then
			-- block empty
		else
			gohelper.setActive(var_29_2.gameObject, var_29_8)
			transformhelper.setLocalScale(var_29_0, 1.35, 1.35, 1.35)
		end
	else
		gohelper.setActive(var_29_2.gameObject, var_29_8)
		transformhelper.setLocalScale(var_29_0, 1.35, 1.35, 1.35)
	end

	UISpriteSetMgr.instance:setCharacterTalentSprite(var_29_1, "ky_" .. HeroResonanceConfig.instance:getCubeConfig(arg_29_2.cubeId).icon, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(var_29_2, HeroResonanceConfig.instance:getCubeConfig(arg_29_2.cubeId).icon, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(var_29_3, "glow_" .. HeroResonanceConfig.instance:getCubeConfig(arg_29_2.cubeId).icon, true)

	local var_29_9 = arg_29_0._rabbet_cell[arg_29_2.posY][arg_29_2.posX].transform.anchoredPosition.x
	local var_29_10 = arg_29_0._rabbet_cell[arg_29_2.posY][arg_29_2.posX].transform.anchoredPosition.y

	transformhelper.setLocalRotation(var_29_0, 0, 0, -arg_29_2.direction * 90)

	local var_29_11 = arg_29_0.cell_length * GameUtil.getTabLen(var_29_6[0])
	local var_29_12 = arg_29_0.cell_length * GameUtil.getTabLen(var_29_6)
	local var_29_13 = arg_29_2.direction % 2 == 0
	local var_29_14 = var_29_9 + (var_29_13 and var_29_11 or var_29_12) / 2
	local var_29_15 = var_29_10 + -(var_29_13 and var_29_12 or var_29_11) / 2
	local var_29_16 = var_29_14 - arg_29_0.half_length
	local var_29_17 = var_29_15 + arg_29_0.half_length

	recthelper.setAnchor(var_29_0, var_29_16, var_29_17)

	local var_29_18 = {}
	local var_29_19 = GameUtil.getTabLen(var_29_7) - 1
	local var_29_20 = GameUtil.getTabLen(var_29_7[0]) - 1

	for iter_29_0 = 0, var_29_19 do
		for iter_29_1 = 0, var_29_20 do
			if var_29_7[iter_29_0][iter_29_1] == 1 then
				table.insert(var_29_18, {
					arg_29_2.posX + iter_29_1,
					arg_29_2.posY + iter_29_0
				})
			end
		end
	end

	for iter_29_2, iter_29_3 in ipairs(var_29_18) do
		arg_29_0._rabbet_cell[iter_29_3[2]][iter_29_3[1]].is_filled = true

		arg_29_0._rabbet_cell[iter_29_3[2]][iter_29_3[1]]:setCellData(arg_29_2)
	end

	if var_29_8 then
		if not arg_29_0._mainCubeItem and arg_29_0._isCanPlaySwitch then
			var_29_5:Play("chessitem_switch", 0, 0)

			arg_29_0._isCanPlaySwitch = false
		end

		arg_29_0._mainCubeItem = {
			bg = var_29_1,
			icon = var_29_2,
			glow_icon = var_29_3,
			cell_icon = var_29_4,
			anim = var_29_5
		}

		arg_29_0:_refreshMainStyleCubeItem()
		gohelper.setActive(var_29_2.gameObject, true)
	else
		gohelper.setActive(var_29_4.gameObject, false)
	end
end

function var_0_0._refreshMainStyleCubeItem(arg_30_0)
	local var_30_0 = HeroResonanceConfig.instance:getCubeConfig(arg_30_0._mainCubeId).icon
	local var_30_1 = "ky_" .. var_30_0
	local var_30_2 = var_30_0
	local var_30_3 = "glow_" .. var_30_0
	local var_30_4 = string.split(var_30_0, "_")
	local var_30_5 = "gz_" .. var_30_4[#var_30_4]
	local var_30_6 = arg_30_0.hero_mo_data:getHeroUseStyleCubeId()

	arg_30_0._showTalentStyle = var_30_6

	local var_30_7 = HeroResonanceConfig.instance:getCubeConfig(var_30_6)
	local var_30_8 = var_30_6 == arg_30_0._mainCubeId

	if not var_30_8 and var_30_7 then
		local var_30_9 = var_30_7.icon

		if not string.nilorempty(var_30_9) then
			var_30_1 = "ky_" .. var_30_9
			var_30_2 = "mk_" .. var_30_9
			var_30_3 = var_30_2
		end
	end

	if arg_30_0.drag_dic_image then
		local var_30_10 = arg_30_0.drag_dic_image[arg_30_0._mainCubeId]

		if var_30_10 then
			local var_30_11 = var_30_10:GetComponent(gohelper.Type_Image)

			UISpriteSetMgr.instance:setCharacterTalentSprite(var_30_11, var_30_2, true)
		end
	end

	if arg_30_0._mainCubeItem then
		UISpriteSetMgr.instance:setCharacterTalentSprite(arg_30_0._mainCubeItem.bg, var_30_1, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(arg_30_0._mainCubeItem.icon, var_30_2, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(arg_30_0._mainCubeItem.glow_icon, var_30_3, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(arg_30_0._mainCubeItem.cell_icon, var_30_5, true)
		gohelper.setActive(arg_30_0._mainCubeItem.cell_icon.gameObject, not var_30_8)
	end
end

function var_0_0._rotationMatrix(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_1

	while arg_31_2 > 0 do
		var_31_0 = {}

		local var_31_1 = GameUtil.getTabLen(arg_31_1)
		local var_31_2 = GameUtil.getTabLen(arg_31_1[0])

		for iter_31_0 = 0, var_31_2 - 1 do
			var_31_0[iter_31_0] = {}

			for iter_31_1 = 0, var_31_1 - 1 do
				var_31_0[iter_31_0][iter_31_1] = arg_31_1[var_31_1 - iter_31_1 - 1][iter_31_0]
			end
		end

		arg_31_2 = arg_31_2 - 1

		if arg_31_2 > 0 then
			arg_31_1 = var_31_0
		end
	end

	return var_31_0
end

function var_0_0._setDebrisData(arg_32_0)
	local var_32_0 = arg_32_0.hero_mo_data.talentCubeInfos.own_cube_list

	arg_32_0.own_cube_list = var_32_0

	table.sort(var_32_0, function(arg_33_0, arg_33_1)
		local var_33_0 = HeroResonanceConfig.instance:getCubeConfig(arg_33_0.id)
		local var_33_1 = HeroResonanceConfig.instance:getCubeConfig(arg_33_1.id)

		return var_33_0.sort < var_33_1.sort
	end)

	arg_32_0._cubeRoot = arg_32_0:getUserDataTb_()

	gohelper.CreateObjList(arg_32_0, arg_32_0._onDebrisItemShow, var_32_0, arg_32_0._goContent, arg_32_0._goinspirationItem)
	gohelper.setActive(arg_32_0._goEmpty, #var_32_0 == 0)
	gohelper.setActive(arg_32_0._goMaxLevel, #var_32_0 > 0)

	local var_32_1 = TalentStyleModel.instance:isUnlockStyleSystem(arg_32_0.hero_mo_data.talent)

	gohelper.setActive(arg_32_0._gostylechange, var_32_1)

	if arg_32_0._isPlayScrollTween then
		if arg_32_0.parallel_sequence then
			arg_32_0.parallel_sequence:onDestroyInternal()

			arg_32_0.parallel_sequence = nil
		end

		if arg_32_0.cubeItemList then
			for iter_32_0, iter_32_1 in ipairs(arg_32_0.cubeItemList) do
				recthelper.setAnchorY(iter_32_1.tr.transform, iter_32_1.anchorY)

				iter_32_1.cangroup.alpha = 1
			end
		end

		arg_32_0._goContent:GetComponent(gohelper.Type_VerticalLayoutGroup).enabled = true
		arg_32_0._goContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = true
		arg_32_0._isPlayScrollTween = nil
	end
end

function var_0_0._onDebrisItemShow(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = arg_34_1.transform

	arg_34_1.name = arg_34_3

	local var_34_1 = var_34_0:Find("item/slot"):GetComponent(gohelper.Type_Image)
	local var_34_2 = var_34_0:Find("item/slot/icon"):GetComponent(gohelper.Type_Image)
	local var_34_3 = var_34_0:Find("item/slot/countbg")
	local var_34_4 = var_34_0:Find("item/slot/countbg/count"):GetComponent(gohelper.Type_TextMesh)
	local var_34_5 = var_34_0:Find("item/slot/glow"):GetComponent(gohelper.Type_Image)
	local var_34_6 = var_34_0:Find("level/level"):GetComponent(gohelper.Type_TextMesh)
	local var_34_7 = var_34_0:Find("stylebg")

	SLFramework.UGUI.UIDragListener.Get(var_34_1.gameObject):AddDragBeginListener(arg_34_0._onDragBegin, arg_34_0, arg_34_2.id)
	SLFramework.UGUI.UIDragListener.Get(var_34_1.gameObject):AddDragListener(arg_34_0._onDrag, arg_34_0)
	SLFramework.UGUI.UIDragListener.Get(var_34_1.gameObject):AddDragEndListener(arg_34_0._onDragEnd, arg_34_0)
	SLFramework.UGUI.UIClickListener.Get(var_34_1.gameObject):AddClickDownListener(arg_34_0._onClickDownHandler, arg_34_0)
	recthelper.setAnchorX(var_34_3.transform, 3.4 - 56 * HeroResonanceConfig.instance:getLastRowfulPos(arg_34_2.id))

	var_34_4.text = arg_34_2.own
	var_34_6.text = "Lv." .. arg_34_2.level

	local var_34_8 = arg_34_0._cubeRoot[arg_34_2.id] or {
		root = var_34_0:Find("attributeContent").gameObject,
		item = var_34_0:Find("attributeContent/attributeItem").gameObject,
		levelTxt = var_34_6,
		Icon = var_34_2,
		glow_icon = var_34_5,
		cell_bg = var_34_1,
		countbg = var_34_3,
		anim = arg_34_1:GetComponent(typeof(UnityEngine.Animator))
	}

	arg_34_0._cubeRoot[arg_34_2.id] = var_34_8

	local var_34_9 = arg_34_0._mainCubeId == arg_34_2.id

	arg_34_0:_refreshAttrItem(arg_34_2.id)
	gohelper.setActive(var_34_7, var_34_9)
end

function var_0_0._refreshAttrItem(arg_35_0, arg_35_1, arg_35_2)
	if not arg_35_0._cubeRoot then
		return
	end

	local var_35_0 = arg_35_0._cubeRoot[arg_35_1].root
	local var_35_1 = arg_35_0._cubeRoot[arg_35_1].item
	local var_35_2 = arg_35_0._cubeRoot[arg_35_1].levelTxt
	local var_35_3 = arg_35_0._cubeRoot[arg_35_1].anim
	local var_35_4 = arg_35_0.hero_mo_data:getCurTalentLevelConfig(arg_35_1)
	local var_35_5 = {}

	arg_35_0.hero_mo_data:getTalentStyleCubeAttr(arg_35_1, var_35_5, nil, nil, arg_35_2)

	local var_35_6 = {}

	for iter_35_0, iter_35_1 in pairs(var_35_5) do
		table.insert(var_35_6, {
			key = iter_35_0,
			value = iter_35_1,
			is_special = var_35_4.calculateType == 1,
			config = var_35_4
		})
	end

	table.sort(var_35_6, function(arg_36_0, arg_36_1)
		return HeroConfig.instance:getIDByAttrType(arg_36_0.key) < HeroConfig.instance:getIDByAttrType(arg_36_1.key)
	end)

	local var_35_7 = HeroResonanceConfig.instance:getCubeConfig(arg_35_1).icon
	local var_35_8 = "glow_" .. var_35_7
	local var_35_9 = string.split(var_35_7, "_")
	local var_35_10 = "gz_" .. var_35_9[#var_35_9]
	local var_35_11 = arg_35_0:getMainStyleCube(arg_35_1)

	if var_35_11 then
		local var_35_12 = HeroResonanceConfig.instance:getCubeConfig(var_35_11)

		if var_35_12 then
			var_35_7 = "mk_" .. var_35_12.icon
			var_35_8 = var_35_7
			var_35_10 = var_35_10 .. "_2"
		end
	end

	local function var_35_13()
		var_35_2.text = "Lv." .. (arg_35_2 or var_35_4.level)

		gohelper.CreateObjList(arg_35_0, arg_35_0._onDebrisAttrItemShow, var_35_6, var_35_0, var_35_1)
		UISpriteSetMgr.instance:setCharacterTalentSprite(arg_35_0._cubeRoot[arg_35_1].Icon, var_35_7, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(arg_35_0._cubeRoot[arg_35_1].glow_icon, var_35_8, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(arg_35_0._cubeRoot[arg_35_1].cell_bg, var_35_10, true)

		if arg_35_2 == nil and not arg_35_0._showMaxLVBtn then
			arg_35_0._showMaxLVBtn = true

			arg_35_0:_showMaxLvBtn()
		end
	end

	if arg_35_1 == arg_35_0._mainCubeId and arg_35_2 == nil and arg_35_0._canPlayCubeAnim then
		TaskDispatcher.cancelTask(var_35_13, arg_35_0)
		var_35_3:Play("switch", 0, 0)
		TaskDispatcher.runDelay(var_35_13, arg_35_0, 0.16)

		arg_35_0._canPlayCubeAnim = false
	else
		var_35_13()
	end
end

function var_0_0._onDebrisAttrItemShow(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = arg_38_1.transform
	local var_38_1 = var_38_0:Find("icon"):GetComponent(gohelper.Type_Image)
	local var_38_2 = var_38_0:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local var_38_3 = var_38_0:Find("name/num"):GetComponent(gohelper.Type_TextMesh)
	local var_38_4 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(arg_38_2.key))

	var_38_2.text = var_38_4.name

	UISpriteSetMgr.instance:setCommonSprite(var_38_1, "icon_att_" .. var_38_4.id)

	if var_38_4.type ~= 1 then
		arg_38_2.value = arg_38_2.value / 10 .. "%"
	elseif not arg_38_2.is_special then
		arg_38_2.value = arg_38_2.config[arg_38_2.key] / 10 .. "%"
	else
		arg_38_2.value = math.floor(arg_38_2.value)
	end

	var_38_3.text = "+" .. arg_38_2.value
end

function var_0_0.showCurSelectCubeAttr(arg_39_0, arg_39_1)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)
	gohelper.setActive(arg_39_0._gotip, true)

	local var_39_0 = {}

	arg_39_0.hero_mo_data:getTalentStyleCubeAttr(arg_39_1.cubeId, var_39_0)

	local var_39_1 = {}
	local var_39_2 = arg_39_0.hero_mo_data:getCurTalentLevelConfig(arg_39_1.cubeId)

	for iter_39_0, iter_39_1 in pairs(var_39_0) do
		table.insert(var_39_1, {
			key = iter_39_0,
			value = iter_39_1,
			is_special = var_39_2.calculateType == 1,
			config = var_39_2
		})
	end

	table.sort(var_39_1, function(arg_40_0, arg_40_1)
		return HeroConfig.instance:getIDByAttrType(arg_40_0.key) < HeroConfig.instance:getIDByAttrType(arg_40_1.key)
	end)
	table.insert(var_39_1, 1, {})
	gohelper.CreateObjList(arg_39_0, arg_39_0._onShowSingleCubeAttrTips, var_39_1, arg_39_0._gosingleTipsContent, arg_39_0._gosingleAttributeItem)

	local var_39_3 = gohelper.findChild(arg_39_0._gochessContainer, string.format("%s_%s_%s_%s", arg_39_1.cubeId, arg_39_1.direction, arg_39_1.posX, arg_39_1.posY))

	if var_39_3 then
		local var_39_4 = var_39_3.transform
		local var_39_5 = 1.45

		transformhelper.setLocalScale(var_39_4, var_39_5, var_39_5, var_39_5)
		gohelper.setActive(var_39_4:Find("icon").gameObject, true)
	end
end

function var_0_0._onShowSingleCubeAttrTips(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	if arg_41_3 ~= 1 then
		local var_41_0 = arg_41_1.transform
		local var_41_1 = var_41_0:Find("icon"):GetComponent(gohelper.Type_Image)
		local var_41_2 = var_41_0:Find("name"):GetComponent(gohelper.Type_TextMesh)
		local var_41_3 = var_41_0:Find("num"):GetComponent(gohelper.Type_TextMesh)
		local var_41_4 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(arg_41_2.key))

		var_41_2.text = var_41_4.name

		UISpriteSetMgr.instance:setCommonSprite(var_41_1, "icon_att_" .. var_41_4.id)

		if var_41_4.type ~= 1 then
			arg_41_2.value = arg_41_2.value / 10 .. "%"
		elseif not arg_41_2.is_special then
			arg_41_2.value = arg_41_2.config[arg_41_2.key] / 10 .. "%"
		else
			arg_41_2.value = math.floor(arg_41_2.value)
		end

		var_41_3.text = arg_41_2.value
	end
end

function var_0_0._onContainerDragBegin(arg_42_0, arg_42_1, arg_42_2)
	arg_42_0:_btnCloseTipOnClick()

	arg_42_0.is_draging = true

	local var_42_0 = recthelper.screenPosToAnchorPos(arg_42_2.position, arg_42_0._gomeshContainer.transform)
	local var_42_1, var_42_2 = recthelper.getAnchor(arg_42_0.drag_container_transform)

	arg_42_0.drag_offset_x = var_42_1 - var_42_0.x
	arg_42_0.drag_offset_y = var_42_2 - var_42_0.y
end

function var_0_0._onContainerDrag(arg_43_0, arg_43_1, arg_43_2)
	if not arg_43_0.drag_data then
		return
	end

	local var_43_0 = recthelper.screenPosToAnchorPos(arg_43_2.position, arg_43_0._gomeshContainer.transform)

	recthelper.setAnchor(arg_43_0.drag_container_transform, var_43_0.x + (arg_43_0.drag_offset_x or 0), var_43_0.y + (arg_43_0.drag_offset_y or 0))
	arg_43_0:_detectDragResult()
end

function var_0_0._onDragBegin(arg_44_0, arg_44_1, arg_44_2)
	arg_44_0:_btnCloseTipOnClick()

	if arg_44_0.recover_data then
		arg_44_0:_setChessboardData()

		arg_44_0.cur_drag_is_get = nil
		arg_44_0.recover_data = nil
	end

	arg_44_0:_createDragItem(arg_44_1)
end

function var_0_0._onDrag(arg_45_0, arg_45_1, arg_45_2)
	if not arg_45_0.drag_data then
		return
	end

	local var_45_0 = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), arg_45_0._gomeshContainer.transform)

	recthelper.setAnchor(arg_45_0.drag_container_transform, var_45_0.x, var_45_0.y)
	arg_45_0:_detectDragResult()
end

function var_0_0._detectDragResult(arg_46_0)
	arg_46_0.cur_fill_count = 0
	arg_46_0.cross_point = false

	arg_46_0:setChessCubeIconAlpha()

	for iter_46_0, iter_46_1 in ipairs(arg_46_0._rabbet_cell_list) do
		local var_46_0 = iter_46_1

		var_46_0:SetNormal()

		for iter_46_2, iter_46_3 in ipairs(arg_46_0.drag_cube_child_list[arg_46_0.drag_data.drag_id]) do
			local var_46_1 = iter_46_3.transform
			local var_46_2 = recthelper.getAnchorX(var_46_1)
			local var_46_3 = recthelper.getAnchorY(var_46_1)
			local var_46_4 = -arg_46_0.drag_data.direction * 90
			local var_46_5 = recthelper.getAnchorX(arg_46_0.drag_container_transform) + var_46_2 * math.cos(math.rad(var_46_4)) - var_46_3 * math.sin(math.rad(var_46_4))
			local var_46_6 = recthelper.getAnchorY(arg_46_0.drag_container_transform) + var_46_2 * math.sin(math.rad(var_46_4)) + var_46_3 * math.cos(math.rad(var_46_4))

			if var_46_0:detectPosCover(var_46_5, var_46_6) then
				if iter_46_3.rightful then
					if var_46_0.is_filled then
						var_46_0:SetRed()

						if arg_46_0.setChessCubeIconAlpha then
							arg_46_0:setChessCubeIconAlpha(var_46_0.cell_data)
						end
					else
						arg_46_0.cur_fill_count = arg_46_0.cur_fill_count + 1
					end
				end

				if arg_46_0.drag_cube_top_left_child == var_46_1 then
					arg_46_0.adsorbent_pos_x = var_46_0.pos_x
					arg_46_0.adsorbent_pos_y = var_46_0.pos_y
				end

				arg_46_0.cross_point = true
				arg_46_0.release_offset_x = var_46_0.position_x - var_46_5
				arg_46_0.release_offset_y = var_46_0.position_y - var_46_6
			end
		end
	end

	if arg_46_0.cur_fill_count == HeroResonanceConfig.instance:getCubeRightful(arg_46_0.drag_data.drag_id) then
		local var_46_7 = GameUtil.getTabLen(arg_46_0.cur_matrix) - 1
		local var_46_8 = GameUtil.getTabLen(arg_46_0.cur_matrix[0]) - 1
		local var_46_9 = arg_46_0.adsorbent_pos_x
		local var_46_10 = arg_46_0.adsorbent_pos_y

		for iter_46_4 = 0, var_46_7 do
			for iter_46_5 = 0, var_46_8 do
				if arg_46_0.cur_matrix[iter_46_4][iter_46_5] == 1 then
					if not arg_46_0._rabbet_cell[var_46_10 + iter_46_4][var_46_9 + iter_46_5] then
						logError(iter_46_5, iter_46_4, var_46_9, var_46_10)
					end

					if not arg_46_0.cur_matrix[iter_46_4 - 1] or arg_46_0.cur_matrix[iter_46_4 - 1][iter_46_5] ~= 1 then
						arg_46_0._rabbet_cell[var_46_10 + iter_46_4][var_46_9 + iter_46_5]:lightTop()
					end

					if not arg_46_0.cur_matrix[iter_46_4][iter_46_5 + 1] or arg_46_0.cur_matrix[iter_46_4][iter_46_5 + 1] ~= 1 then
						arg_46_0._rabbet_cell[var_46_10 + iter_46_4][var_46_9 + iter_46_5]:lightRight()
					end

					if not arg_46_0.cur_matrix[iter_46_4 + 1] or arg_46_0.cur_matrix[iter_46_4 + 1][iter_46_5] ~= 1 then
						arg_46_0._rabbet_cell[var_46_10 + iter_46_4][var_46_9 + iter_46_5]:lightBottom()
					end

					if not arg_46_0.cur_matrix[iter_46_4][iter_46_5 - 1] or arg_46_0.cur_matrix[iter_46_4][iter_46_5 - 1] ~= 1 then
						arg_46_0._rabbet_cell[var_46_10 + iter_46_4][var_46_9 + iter_46_5]:lightLeft()
					end

					if arg_46_0.cur_matrix[iter_46_4 - 1] and arg_46_0.cur_matrix[iter_46_4 - 1][iter_46_5] == 1 then
						arg_46_0._rabbet_cell[var_46_10 + iter_46_4][var_46_9 + iter_46_5]:hideTop()
					end

					if arg_46_0.cur_matrix[iter_46_4][iter_46_5 + 1] == 1 then
						arg_46_0._rabbet_cell[var_46_10 + iter_46_4][var_46_9 + iter_46_5]:hideRight()
					end

					if arg_46_0.cur_matrix[iter_46_4 + 1] and arg_46_0.cur_matrix[iter_46_4 + 1][iter_46_5] == 1 then
						arg_46_0._rabbet_cell[var_46_10 + iter_46_4][var_46_9 + iter_46_5]:hideBottom()
					end

					if arg_46_0.cur_matrix[iter_46_4][iter_46_5 - 1] == 1 then
						arg_46_0._rabbet_cell[var_46_10 + iter_46_4][var_46_9 + iter_46_5]:hideLeft()
					end
				end
			end
		end
	end
end

function var_0_0._onDragEnd(arg_47_0, arg_47_1, arg_47_2)
	arg_47_0.is_draging = false
	arg_47_0.recover_data = nil

	if not arg_47_0.drag_data then
		arg_47_0:_releaseDragItem()

		arg_47_0.cur_fill_count = 0

		return
	end

	if arg_47_0._dragEffectLoader and arg_47_0.cur_fill_count < 2 then
		arg_47_0.cur_fill_count = 0
		arg_47_0.cross_point = nil
	end

	if arg_47_0.cur_fill_count == HeroResonanceConfig.instance:getCubeRightful(arg_47_0.drag_data.drag_id) then
		arg_47_0.ignore_refresh_list = arg_47_0.cur_drag_is_get

		arg_47_0:releaseFromChess()

		arg_47_0.put_cube_ani = arg_47_0.drag_data
		arg_47_0.drag_data.posX = arg_47_0.adsorbent_pos_x
		arg_47_0.drag_data.posY = arg_47_0.adsorbent_pos_y

		if arg_47_0.cur_select_cell_data then
			arg_47_0.cur_select_cell_data.cubeId = arg_47_0.put_cube_ani.drag_id
			arg_47_0.cur_select_cell_data.posX = arg_47_0.drag_data.posX
			arg_47_0.cur_select_cell_data.posY = arg_47_0.drag_data.posY
			arg_47_0.cur_select_cell_data.direction = arg_47_0.drag_data.direction

			arg_47_0:requestPutCube()

			arg_47_0.cur_fill_count = 0

			return
		end

		local var_47_0 = arg_47_0._rabbet_cell[arg_47_0.adsorbent_pos_y][arg_47_0.adsorbent_pos_x].transform:InverseTransformPoint(arg_47_0.drag_cube_top_left_child.position)

		arg_47_0._put_ani_flow = arg_47_0._put_ani_flow or FlowParallel.New()

		arg_47_0._put_ani_flow:destroy()
		arg_47_0._put_ani_flow:ctor()
		arg_47_0._put_ani_flow:addWork(TweenWork.New({
			type = "DOAnchorPos",
			t = 0.1,
			tr = arg_47_0.drag_container_transform,
			tox = recthelper.getAnchorX(arg_47_0.drag_container_transform) - var_47_0.x,
			toy = recthelper.getAnchorY(arg_47_0.drag_container_transform) - var_47_0.y,
			ease = EaseType.InCubic
		}))
		arg_47_0._put_ani_flow:addWork(TweenWork.New({
			toz = 1,
			type = "DOScale",
			tox = 1.35,
			toy = 1.35,
			t = 0.1,
			tr = arg_47_0.drag_dic_image[arg_47_0.drag_data.drag_id],
			ease = EaseType.InCubic
		}))
		arg_47_0._put_ani_flow:registerDoneListener(arg_47_0.onPutAniDone, arg_47_0)

		if arg_47_0._rabbet_cell_list then
			for iter_47_0, iter_47_1 in ipairs(arg_47_0._rabbet_cell_list) do
				iter_47_1:hideEmptyBg()
			end
		end

		arg_47_0.drag_data = nil

		arg_47_0._put_ani_flow:start()
	elseif arg_47_0.cross_point then
		AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_property_fail)

		local var_47_1 = recthelper.getAnchorX(arg_47_0.drag_container_transform)
		local var_47_2 = recthelper.getAnchorY(arg_47_0.drag_container_transform)

		recthelper.setAnchor(arg_47_0.drag_container_transform, var_47_1 + arg_47_0.release_offset_x, var_47_2 + arg_47_0.release_offset_y)

		if arg_47_0.cur_drag_is_get then
			arg_47_0.recover_data = {}
			arg_47_0.recover_data.drag_id = arg_47_0.drag_data.drag_id
			arg_47_0.recover_data.initial_direction = arg_47_0.drag_data.initial_direction
			arg_47_0.recover_data.posX = arg_47_0.drag_data.posX
			arg_47_0.recover_data.posY = arg_47_0.drag_data.posY
		end
	else
		arg_47_0:releaseFromChess()
		AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_property_click)
		arg_47_0:_releaseDragItem()
	end

	arg_47_0.cur_fill_count = 0
end

function var_0_0.releaseFromChess(arg_48_0)
	if arg_48_0.cur_drag_is_get then
		if arg_48_0.drag_data.drag_id and arg_48_0.drag_data.initial_direction and arg_48_0.drag_data.posX and arg_48_0.drag_data.posY then
			HeroRpc.instance:PutTalentCubeRequest(arg_48_0.hero_mo_data.heroId, HeroResonanceEnum.GetCube, arg_48_0.drag_data.drag_id, arg_48_0.drag_data.initial_direction, arg_48_0.drag_data.posX, arg_48_0.drag_data.posY)
		else
			arg_48_0:_onRefreshCubeList()
		end
	end

	arg_48_0.cur_drag_is_get = nil
end

function var_0_0._onClickDownHandler(arg_49_0)
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_property_click)
end

function var_0_0.onPutAniDone(arg_50_0)
	arg_50_0._put_ani_flow:unregisterDoneListener(arg_50_0.onPutAniDone, arg_50_0)

	arg_50_0.drag_data = arg_50_0.put_cube_ani

	arg_50_0:requestPutCube()
end

function var_0_0.requestPutCube(arg_51_0)
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_property_success)
	HeroRpc.instance:PutTalentCubeRequest(arg_51_0.hero_mo_data.heroId, HeroResonanceEnum.PutCube, arg_51_0.drag_data.drag_id, arg_51_0.drag_data.direction, arg_51_0.adsorbent_pos_x, arg_51_0.adsorbent_pos_y)
	arg_51_0:_releaseDragItem()
end

function var_0_0._releaseDragItem(arg_52_0)
	arg_52_0.cross_point = false

	if arg_52_0.drag_data then
		gohelper.setActive(arg_52_0.drag_container_transform:Find(arg_52_0.drag_data.drag_id).gameObject, false)
	end

	arg_52_0.drag_data = nil

	arg_52_0:RefreshAllCellLine()
	gohelper.setActive(arg_52_0.drag_container, false)
end

function var_0_0._createDragItem(arg_53_0, arg_53_1, arg_53_2, arg_53_3, arg_53_4)
	if arg_53_0._dragEffectLoader and arg_53_1 ~= 18 then
		return
	end

	if not arg_53_0.drag_container then
		arg_53_0.drag_container = arg_53_0._godragContainer
		arg_53_0.drag_container_transform = arg_53_0.drag_container.transform
		arg_53_0._dragContainerDragCom = SLFramework.UGUI.UIDragListener.Get(arg_53_0.drag_container)

		arg_53_0._dragContainerDragCom:AddDragBeginListener(arg_53_0._onContainerDragBegin, arg_53_0)
		arg_53_0._dragContainerDragCom:AddDragListener(arg_53_0._onContainerDrag, arg_53_0)
		arg_53_0._dragContainerDragCom:AddDragEndListener(arg_53_0._onDragEnd, arg_53_0)
		SLFramework.UGUI.UIClickListener.Get(arg_53_0.drag_container):AddClickListener(arg_53_0._rotateCube, arg_53_0)
	end

	transformhelper.setLocalRotation(arg_53_0.drag_container_transform, 0, 0, 0)

	local var_53_0 = arg_53_0.drag_container_transform:Find(arg_53_1) or gohelper.clone(arg_53_0._gocellModel, arg_53_0.drag_container, arg_53_1)

	gohelper.setActive(arg_53_0.drag_container, true)

	if arg_53_0.drag_data then
		gohelper.setActive(arg_53_0.drag_container_transform:Find(arg_53_0.drag_data.drag_id).gameObject, false)
	else
		arg_53_0.drag_data = {}
	end

	arg_53_0.drag_data.drag_id = arg_53_1
	arg_53_0.drag_data.direction = arg_53_2 or 0
	arg_53_0.drag_data.initial_direction = arg_53_2 or 0

	local var_53_1 = var_53_0.gameObject

	if not arg_53_0.drag_cube_child_list then
		arg_53_0.drag_cube_child_list = {}
	end

	if not arg_53_0.drag_cube_child_list[arg_53_1] then
		arg_53_0.drag_cube_child_list[arg_53_1] = {}

		arg_53_0:_createDragCubeChild(arg_53_0.drag_cube_child_list[arg_53_1], arg_53_1, var_53_1)
	end

	local var_53_2 = 1.45

	transformhelper.setLocalScale(arg_53_0.drag_dic_image[arg_53_0.drag_data.drag_id], var_53_2, var_53_2, 1)
	gohelper.setActive(var_53_1, true)
	arg_53_0:_setTopLeftTarget()
end

function var_0_0._createDragCubeChild(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = arg_54_0:_rotationMatrix(HeroResonanceConfig.instance:getCubeMatrix(arg_54_2), 0)
	local var_54_1 = GameUtil.getTabLen(var_54_0) - 1
	local var_54_2 = GameUtil.getTabLen(var_54_0[0]) - 1
	local var_54_3 = 0
	local var_54_4 = 0

	for iter_54_0 = 0, var_54_1 do
		for iter_54_1 = 0, var_54_2 do
			if var_54_0[iter_54_0][iter_54_1] == 1 and iter_54_1 <= var_54_3 then
				var_54_3 = iter_54_1

				if var_54_4 <= iter_54_0 then
					var_54_4 = iter_54_0
				end
			end
		end
	end

	local var_54_5

	if not arg_54_0.drag_cube_origin_mat then
		arg_54_0.drag_cube_origin_mat = {}
	end

	if not arg_54_0.drag_cube_origin_mat[arg_54_2] then
		arg_54_0.drag_cube_origin_mat[arg_54_2] = {}
	end

	for iter_54_2 = 0, var_54_1 do
		arg_54_0.drag_cube_origin_mat[arg_54_2][iter_54_2] = {}

		for iter_54_3 = 0, var_54_2 do
			local var_54_6 = arg_54_0:getUserDataTb_()

			var_54_6.gameObject = gohelper.clone(arg_54_0._gocellModel, arg_54_3)
			var_54_6.transform = var_54_6.gameObject.transform
			var_54_6.rightful = var_54_0[iter_54_2][iter_54_3] == 1

			local var_54_7 = (iter_54_3 - var_54_3) * arg_54_0.cell_length
			local var_54_8 = (var_54_4 - iter_54_2) * arg_54_0.cell_length

			recthelper.setAnchor(var_54_6.gameObject.transform, var_54_7, var_54_8)

			arg_54_0.drag_cube_origin_mat[arg_54_2][iter_54_2][iter_54_3] = var_54_6.gameObject

			table.insert(arg_54_1, var_54_6)

			if iter_54_2 == 0 and iter_54_3 == 0 then
				local var_54_9 = gohelper.clone(arg_54_0._goraychessitem, var_54_6.gameObject)

				gohelper.setActive(var_54_9, true)

				local var_54_10 = var_54_9:GetComponent(gohelper.Type_Image)
				local var_54_11 = HeroResonanceConfig.instance:getCubeConfig(arg_54_2).icon
				local var_54_12 = arg_54_0:getMainStyleCube(arg_54_2)

				if var_54_12 then
					local var_54_13 = HeroResonanceConfig.instance:getCubeConfig(var_54_12)

					if var_54_13 then
						var_54_11 = "mk_" .. var_54_13.icon
					end
				end

				UISpriteSetMgr.instance:setCharacterTalentSprite(var_54_10, var_54_11, true)

				local var_54_14 = arg_54_0.cell_length * GameUtil.getTabLen(var_54_0[0])
				local var_54_15 = arg_54_0.cell_length * GameUtil.getTabLen(var_54_0)

				recthelper.setAnchor(var_54_9.transform, var_54_14 / 2 - arg_54_0.half_length, -(var_54_15 / 2) + arg_54_0.half_length)

				if not arg_54_0.drag_image then
					arg_54_0.drag_image = arg_54_0:getUserDataTb_()
				end

				if not arg_54_0.drag_dic_image then
					arg_54_0.drag_dic_image = arg_54_0:getUserDataTb_()
				end

				SLFramework.UGUI.UIDragListener.Get(var_54_9):AddDragBeginListener(arg_54_0._onContainerDragBegin, arg_54_0)
				SLFramework.UGUI.UIDragListener.Get(var_54_9):AddDragListener(arg_54_0._onContainerDrag, arg_54_0)
				SLFramework.UGUI.UIDragListener.Get(var_54_9):AddDragEndListener(arg_54_0._onDragEnd, arg_54_0)
				SLFramework.UGUI.UIClickListener.Get(var_54_9):AddClickListener(arg_54_0._rotateCube, arg_54_0)
				table.insert(arg_54_0.drag_image, var_54_9)

				arg_54_0.drag_dic_image[arg_54_2] = var_54_9.transform
			end
		end
	end
end

function var_0_0.getMainStyleCube(arg_55_0, arg_55_1)
	if arg_55_1 == arg_55_0._mainCubeId then
		local var_55_0 = arg_55_0.hero_mo_data:getHeroUseStyleCubeId()

		if var_55_0 ~= arg_55_0._mainCubeId then
			return var_55_0
		end
	end
end

function var_0_0._setTopLeftTarget(arg_56_0)
	arg_56_0.drag_cube_top_left_child = arg_56_0:_rotationMatrix(arg_56_0.drag_cube_origin_mat[arg_56_0.drag_data.drag_id], arg_56_0.drag_data.direction)[0][0].transform
	arg_56_0.cur_matrix = arg_56_0:_rotationMatrix(HeroResonanceConfig.instance:getCubeMatrix(arg_56_0.drag_data.drag_id), arg_56_0.drag_data.direction)
end

function var_0_0._onGetCube(arg_57_0, arg_57_1)
	if arg_57_0.recover_data then
		if arg_57_0.recover_data.drag_id == arg_57_1.cubeId and arg_57_0.recover_data.direction == arg_57_1.direction and arg_57_0.recover_data.posX == arg_57_1.posX and arg_57_0.recover_data.posY == arg_57_1.posY then
			-- block empty
		else
			if arg_57_0._rabbet_cell_list then
				for iter_57_0, iter_57_1 in ipairs(arg_57_0._rabbet_cell_list) do
					iter_57_1:hideEmptyBg()
				end
			end

			arg_57_0:_setChessboardData()
		end

		arg_57_0.cur_drag_is_get = nil
		arg_57_0.recover_data = nil
	end

	if arg_57_0._rabbet_cell_list then
		for iter_57_2, iter_57_3 in ipairs(arg_57_0._rabbet_cell_list) do
			if iter_57_3.cell_data == arg_57_1 then
				iter_57_3.is_filled = false
			end
		end
	end

	arg_57_0.cur_fill_count = 0

	arg_57_0:_createDragItem(arg_57_1.cubeId, arg_57_1.direction, arg_57_1.posX, arg_57_1.posY)
	transformhelper.setLocalRotation(arg_57_0.drag_container_transform, 0, 0, -arg_57_0.drag_data.direction * 90)
	arg_57_0:_setTopLeftTarget()

	local var_57_0 = arg_57_0._rabbet_cell[arg_57_1.posY][arg_57_1.posX]

	recthelper.setAnchor(arg_57_0.drag_container_transform, var_57_0.position_x, var_57_0.position_y)

	local var_57_1 = arg_57_0.drag_container_transform.parent.transform:InverseTransformPoint(arg_57_0.drag_cube_top_left_child.position)
	local var_57_2 = var_57_0.position_x - var_57_1.x
	local var_57_3 = var_57_0.position_y - var_57_1.y

	gohelper.setActive(arg_57_0._gochessContainer.transform:Find(string.format("%s_%s_%s_%s", arg_57_1.cubeId, arg_57_1.direction, arg_57_1.posX, arg_57_1.posY)).gameObject, false)
	recthelper.setAnchor(arg_57_0.drag_container_transform, var_57_0.position_x + var_57_2, var_57_0.position_y + var_57_3)

	arg_57_0.cur_drag_is_get = true
	arg_57_0.drag_data.posX = arg_57_1.posX
	arg_57_0.drag_data.posY = arg_57_1.posY

	arg_57_0:RefreshAllCellLine()
end

function var_0_0.onCubeClick(arg_58_0, arg_58_1)
	arg_58_0:_onGetCube(arg_58_1)
	arg_58_0:_rotateCube()
end

function var_0_0._rotateCube(arg_59_0)
	if arg_59_0.is_draging then
		return
	end

	if not arg_59_0.drag_data then
		return
	end

	local var_59_0 = arg_59_0.drag_data.direction + 1

	arg_59_0.drag_data.direction = var_59_0 > 3 and 0 or var_59_0

	if arg_59_0.cur_select_cell_data then
		arg_59_0.cur_select_cell_data.direction = arg_59_0.drag_data.direction
	end

	transformhelper.setLocalRotation(arg_59_0.drag_container_transform, 0, 0, -arg_59_0.drag_data.direction * 90)
	arg_59_0:_setTopLeftTarget()
	arg_59_0:_detectDragResult()
	arg_59_0:_onDragEnd()
end

function var_0_0.onClose(arg_60_0)
	return
end

function var_0_0._releaseCellList(arg_61_0)
	if arg_61_0._rabbet_cell_list then
		for iter_61_0, iter_61_1 in ipairs(arg_61_0._rabbet_cell_list) do
			iter_61_1:releaseSelf()
		end

		arg_61_0._rabbet_cell_list = nil
	end
end

function var_0_0._onBtnPutTalentSchemeRequest(arg_62_0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.PutTalent) then
		GuideModel.instance:setFlag(GuideModel.GuideFlag.PutTalent, nil)
		arg_62_0:_putTalentSchemeRequest()

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.RecommendTalentChess, MsgBoxEnum.BoxType.Yes_No, function()
		arg_62_0:_putTalentSchemeRequest()
	end)
end

function var_0_0._putTalentSchemeRequest(arg_64_0)
	arg_64_0:_releaseOperation()

	local var_64_0 = HeroResonanceConfig.instance:getTalentConfig(arg_64_0.hero_mo_data.heroId, arg_64_0.hero_mo_data.talent)
	local var_64_1 = var_64_0.talentMould

	HeroRpc.instance:PutTalentSchemeRequest(arg_64_0.hero_mo_data.heroId, arg_64_0.hero_mo_data.talent, var_64_1, string.splitToNumber(var_64_0.exclusive, "#")[1])
end

function var_0_0._initTemplateList(arg_65_0)
	table.sort(arg_65_0.hero_mo_data.talentTemplates, var_0_0.sortTemplate)

	local var_65_0 = luaLang("talent_charactertalentchess_template" .. CharacterEnum.TalentTxtByHeroType[arg_65_0.hero_mo_data.config.heroType])
	local var_65_1 = {}
	local var_65_2 = TalentStyleModel.instance:isUnlockStyleSystem(arg_65_0.hero_mo_data.talent)

	for iter_65_0, iter_65_1 in ipairs(arg_65_0.hero_mo_data.talentTemplates) do
		local var_65_3

		if LangSettings.instance:isEn() then
			var_65_3 = string.nilorempty(iter_65_1.name) and var_65_0 .. " " .. iter_65_0 or iter_65_1.name
		else
			var_65_3 = string.nilorempty(iter_65_1.name) and var_65_0 .. iter_65_0 or iter_65_1.name
		end

		if var_65_2 then
			local var_65_4 = TalentStyleModel.instance:getTalentStyle(arg_65_0._mainCubeId, iter_65_1.style)
			local var_65_5 = var_65_4 and var_65_4._styleCo and var_65_4._styleCo.tagicon

			if not string.nilorempty(var_65_5) then
				local var_65_6 = tonumber(var_65_5) - 1

				var_65_3 = string.format("<sprite=%s>", var_65_6) .. var_65_3
			end
		end

		table.insert(var_65_1, var_65_3)

		if iter_65_1.id == arg_65_0.hero_mo_data.useTalentTemplateId then
			arg_65_0._curSelectTemplateIndex = iter_65_0
			arg_65_0._txtgroupname.text = var_65_3
		end
	end

	arg_65_0._dropresonategroup:ClearOptions()
	arg_65_0._dropresonategroup:AddOptions(var_65_1)
	arg_65_0._dropresonategroup:SetValue(arg_65_0._curSelectTemplateIndex - 1)

	arg_65_0._templateInitDone = true
end

function var_0_0._opDropdownChange(arg_66_0, arg_66_1)
	if not arg_66_0._templateInitDone then
		return
	end

	arg_66_1 = arg_66_1 or 0

	local var_66_0 = arg_66_1 + 1

	if arg_66_0._curSelectTemplateIndex ~= var_66_0 then
		arg_66_0._curSelectTemplateIndex = var_66_0

		HeroRpc.instance:UseTalentTemplateRequest(arg_66_0.hero_mo_data.heroId, arg_66_0.hero_mo_data.talentTemplates[var_66_0].id)
	end
end

function var_0_0._releaseOperation(arg_67_0)
	arg_67_0:_btnCloseTipOnClick()
	arg_67_0:_releaseDragItem()
	arg_67_0:setChessCubeIconAlpha()
end

function var_0_0._onUseTalentTemplateReply(arg_68_0)
	arg_68_0._isCanPlaySwitch = true
	arg_68_0._mainCubeItem = nil

	arg_68_0:_chooseOtherStyleOrTemplate()
	arg_68_0:_showTemplateName()
end

function var_0_0._playMainCubeSwitchAnim(arg_69_0)
	if arg_69_0._mainCubeItem and arg_69_0._isCanPlaySwitch then
		arg_69_0._mainCubeItem.anim:Play("chessitem_switch", 0, 0)

		arg_69_0._isCanPlaySwitch = false
	end
end

function var_0_0._chooseOtherStyleOrTemplate(arg_70_0)
	arg_70_0:_releaseOperation()
	arg_70_0:_refreshStyleTag()
	arg_70_0:_refreshMainStyleCubeItem()
	TaskDispatcher.cancelTask(arg_70_0._hideStyleUpdateAnim, arg_70_0)
	gohelper.setActive(arg_70_0._styleupdate, true)
	TaskDispatcher.runDelay(arg_70_0._hideStyleUpdateAnim, arg_70_0, 0.6)
end

function var_0_0._onRenameTalentTemplateReply(arg_71_0)
	arg_71_0:_initTemplateList()
end

function var_0_0._onUseTalentStyleReply(arg_72_0)
	arg_72_0:_cutTalentStyle()
end

function var_0_0._cutTalentStyle(arg_73_0)
	local var_73_0 = arg_73_0.hero_mo_data:getHeroUseCubeStyleId()

	if arg_73_0._showTalentStyle == var_73_0 then
		return
	end

	arg_73_0._showTalentStyle = var_73_0
	arg_73_0._isCanPlaySwitch = true

	if not arg_73_0._mainCubeId then
		arg_73_0._mainCubeId = arg_73_0.hero_mo_data.talentCubeInfos.own_main_cube_id
	end

	if arg_73_0._cubeRoot and arg_73_0._cubeRoot[arg_73_0._mainCubeId] then
		local var_73_1 = arg_73_0._cubeRoot[arg_73_0._mainCubeId].root
		local var_73_2 = arg_73_0._cubeRoot[arg_73_0._mainCubeId].item

		if var_73_1 and var_73_2 then
			arg_73_0:_refreshAttrItem(arg_73_0._mainCubeId)
		end
	end

	arg_73_0:_onRefreshCubeList()
	arg_73_0:_setChessboardData()
	arg_73_0:_chooseOtherStyleOrTemplate()

	arg_73_0._canPlayCubeAnim = true

	arg_73_0:_initTemplateList()
	arg_73_0:_playMainCubeSwitchAnim()
end

function var_0_0._hideStyleUpdateAnim(arg_74_0)
	gohelper.setActive(arg_74_0._styleupdate, false)
end

function var_0_0._refreshStyleTag(arg_75_0)
	local var_75_0 = arg_75_0.hero_mo_data:getHeroUseCubeStyleId(arg_75_0.hero_id)
	local var_75_1 = TalentStyleModel.instance:getTalentStyle(arg_75_0._mainCubeId, var_75_0)
	local var_75_2, var_75_3 = var_75_1:getStyleTag()
	local var_75_4, var_75_5 = var_75_1:getStyleTagIcon()

	arg_75_0._txtlabel.text = var_75_2

	UISpriteSetMgr.instance:setCharacterTalentSprite(arg_75_0._styleslot, var_75_5, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(arg_75_0._styleicon, var_75_4, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(arg_75_0._styleglow, var_75_4, true)
end

function var_0_0._showTemplateName(arg_76_0)
	for iter_76_0, iter_76_1 in ipairs(arg_76_0.hero_mo_data.talentTemplates) do
		if iter_76_1.id == arg_76_0.hero_mo_data.useTalentTemplateId then
			local var_76_0 = luaLang("talent_charactertalentchess_template" .. CharacterEnum.TalentTxtByHeroType[arg_76_0.hero_mo_data.config.heroType])
			local var_76_1

			if LangSettings.instance:isEn() then
				var_76_1 = string.nilorempty(iter_76_1.name) and var_76_0 .. " " .. arg_76_0._curSelectTemplateIndex or iter_76_1.name
			else
				var_76_1 = string.nilorempty(iter_76_1.name) and var_76_0 .. arg_76_0._curSelectTemplateIndex or iter_76_1.name
			end

			local var_76_2 = TalentStyleModel.instance:getTalentStyle(arg_76_0._mainCubeId, iter_76_1.style)
			local var_76_3 = var_76_2 and var_76_2._styleCo and var_76_2._styleCo.tagicon

			if not string.nilorempty(var_76_3) then
				local var_76_4 = tonumber(var_76_3) - 1

				var_76_1 = string.format("<sprite=%s>", var_76_4) .. var_76_1
			end

			arg_76_0._txtgroupname.text = var_76_1
		end
	end
end

function var_0_0._onBtnChangeTemplateName(arg_77_0)
	ViewMgr.instance:openView(ViewName.CharacterTalentModifyNameView, {
		arg_77_0.hero_mo_data.heroId,
		arg_77_0.hero_mo_data.talentTemplates[arg_77_0._curSelectTemplateIndex].id
	})
end

function var_0_0.sortTemplate(arg_78_0, arg_78_1)
	return arg_78_0.id < arg_78_1.id
end

function var_0_0._onDropClick(arg_79_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
end

function var_0_0._onStyleChangeClick(arg_80_0)
	local var_80_0 = {
		heroId = arg_80_0.hero_id
	}

	ViewMgr.instance:openView(ViewName.CharacterTalentChessFilterView, var_80_0)
end

function var_0_0._onMaxLevelClick(arg_81_0)
	for iter_81_0, iter_81_1 in pairs(arg_81_0.own_cube_list) do
		local var_81_0 = iter_81_1.id
		local var_81_1 = HeroConfig.instance:getTalentCubeMaxLevel(var_81_0)

		arg_81_0:_refreshAttrItem(var_81_0, arg_81_0._showMaxLVBtn and var_81_1)
	end

	arg_81_0._showMaxLVBtn = not arg_81_0._showMaxLVBtn

	arg_81_0:_showMaxLvBtn()
	arg_81_0._leftContentAnim:Play("chessview_content_open", 0, 0)
	arg_81_0._leftContentAnim:Update(0)
end

function var_0_0._showMaxLvBtn(arg_82_0)
	gohelper.setActive(arg_82_0._gomaxselect, not arg_82_0._showMaxLVBtn)
	gohelper.setActive(arg_82_0._gomaxunselect, arg_82_0._showMaxLVBtn)
end

function var_0_0._onCopyTalentData(arg_83_0)
	local var_83_0 = arg_83_0.hero_mo_data.talentCubeInfos.data_list
	local var_83_1 = ""

	for iter_83_0, iter_83_1 in ipairs(var_83_0) do
		var_83_1 = var_83_1 .. table.concat({
			iter_83_1.cubeId,
			iter_83_1.direction,
			iter_83_1.posX,
			iter_83_1.posY
		}, ",")

		if iter_83_0 ~= #var_83_0 then
			var_83_1 = var_83_1 .. "#"
		end
	end

	ZProj.UGUIHelper.CopyText(var_83_1)
end

function var_0_0._initQuickLayoutItem(arg_84_0)
	arg_84_0._quickLayoutPanel = gohelper.findChild(arg_84_0.viewGO, "#btn_recommend/Template")

	if not arg_84_0._quickLayoutItems then
		arg_84_0._quickLayoutItems = arg_84_0:getUserDataTb_()
	end

	local var_84_0 = gohelper.findChild(arg_84_0._quickLayoutPanel, "Viewport/Content/Item")
	local var_84_1 = HeroResonaceModel.instance:getSpecialCn(arg_84_0.hero_mo_data)

	for iter_84_0, iter_84_1 in ipairs(HeroResonanceEnum.QuickLayoutType) do
		if not arg_84_0._quickLayoutItems[iter_84_0] then
			local var_84_2 = arg_84_0:getUserDataTb_()
			local var_84_3 = gohelper.cloneInPlace(var_84_0, "toggle_" .. iter_84_0)
			local var_84_4 = gohelper.onceAddComponent(var_84_3, typeof(SLFramework.UGUI.ToggleWrap))

			var_84_4:AddOnValueChanged(arg_84_0._onToggleValueChanged, arg_84_0, iter_84_0)

			var_84_2.go = var_84_3
			var_84_2.toggle = var_84_4
			var_84_2.icon = gohelper.findChild(var_84_3, "BG")
			var_84_2.txt = gohelper.findChildText(var_84_3, "Text")

			local var_84_5 = luaLang(iter_84_1.name)

			var_84_2.txt.text = iter_84_1.isNeedParam and GameUtil.getSubPlaceholderLuaLangOneParam(var_84_5, var_84_1) or var_84_5
			arg_84_0._quickLayoutItems[iter_84_0] = var_84_2

			gohelper.setActive(var_84_2.icon, false)
		end

		gohelper.setActive(arg_84_0._quickLayoutItems[iter_84_0].go, true)
	end
end

function var_0_0._onToggleValueChanged(arg_85_0, arg_85_1)
	if arg_85_1 == 1 then
		local var_85_0 = HeroResonaceModel.instance:getCurLayoutShareCode(arg_85_0.hero_mo_data)

		if not string.nilorempty(var_85_0) then
			ZProj.UGUIHelper.CopyText(var_85_0)
			GameFacade.showToast(ToastEnum.CharacterTalentShareCodeCopy)
			HeroResonaceModel.instance:saveShareCode(var_85_0)
			HeroResonanceController.instance:statShareCode(arg_85_0.hero_mo_data, false)
		else
			local var_85_1 = HeroResonaceModel.instance:getSpecialCn(arg_85_0.hero_mo_data)

			ToastController.instance:showToast(ToastEnum.CharacterTalentEmptyLayout, var_85_1)
		end
	elseif arg_85_1 == 2 then
		local var_85_2 = {
			heroMo = arg_85_0.hero_mo_data
		}

		ViewMgr.instance:openView(ViewName.CharacterTalentChessCopyView, var_85_2)
	else
		arg_85_0:_onBtnPutTalentSchemeRequest()
	end

	arg_85_0:_hideQuickLayoutPanel()
end

function var_0_0._activeToggleGraphic(arg_86_0, arg_86_1)
	if not arg_86_0._quickLayoutItems then
		return
	end

	for iter_86_0, iter_86_1 in ipairs(arg_86_0._quickLayoutItems) do
		if iter_86_1.icon then
			gohelper.setActive(iter_86_1.icon.gameObject, arg_86_1 == iter_86_0)
		end
	end
end

function var_0_0._showQuickLayoutPanel(arg_87_0)
	if arg_87_0._quickLayoutPanel then
		local var_87_0 = not arg_87_0._quickLayoutPanel.gameObject.activeSelf

		gohelper.setActive(arg_87_0._quickLayoutPanel, var_87_0)

		local var_87_1 = var_87_0 and -1 or 1

		transformhelper.setLocalScale(arg_87_0._quickLayoutIcon.transform, 1, var_87_1, 1)
	end
end

function var_0_0._hideQuickLayoutPanel(arg_88_0)
	gohelper.setActive(arg_88_0._quickLayoutPanel, false)
	transformhelper.setLocalScale(arg_88_0._quickLayoutIcon.transform, 1, 1, 1)
end

function var_0_0._onUseShareCode(arg_89_0, arg_89_1)
	arg_89_0:_cutTalentStyle()
	HeroResonanceController.instance:statShareCode(arg_89_0.hero_mo_data, true)
end

function var_0_0.onDestroyView(arg_90_0)
	if arg_90_0.parallel_sequence then
		arg_90_0.parallel_sequence:destroy()
	end

	if arg_90_0._update_attr_tips_ani then
		arg_90_0._update_attr_tips_ani:destroy()
	end

	if arg_90_0._put_ani_flow then
		arg_90_0._put_ani_flow:unregisterDoneListener(arg_90_0.onPutAniDone, arg_90_0)
		arg_90_0._put_ani_flow:destroy()
	end

	TaskDispatcher.cancelTask(arg_90_0._playScrollTween, arg_90_0)
	TaskDispatcher.cancelTask(arg_90_0._hideStyleUpdateAnim, arg_90_0)

	local var_90_0 = arg_90_0._goContent.transform
	local var_90_1 = var_90_0.childCount

	for iter_90_0 = 0, var_90_1 - 1 do
		local var_90_2 = var_90_0:GetChild(iter_90_0):Find("item/slot").gameObject
		local var_90_3 = SLFramework.UGUI.UIDragListener.Get(var_90_2)

		var_90_3:RemoveDragBeginListener()
		var_90_3:RemoveDragListener()
		var_90_3:RemoveDragEndListener()
		SLFramework.UGUI.UIClickListener.Get(var_90_2):RemoveClickDownListener()
	end

	if arg_90_0.drag_container then
		arg_90_0._dragContainerDragCom:RemoveDragBeginListener()
		arg_90_0._dragContainerDragCom:RemoveDragListener()
		arg_90_0._dragContainerDragCom:RemoveDragEndListener()
		SLFramework.UGUI.UIClickListener.Get(arg_90_0.drag_container):RemoveClickListener()
	end

	if arg_90_0.drag_image then
		for iter_90_1, iter_90_2 in ipairs(arg_90_0.drag_image) do
			local var_90_4 = SLFramework.UGUI.UIDragListener.Get(iter_90_2)

			var_90_4:RemoveDragBeginListener()
			var_90_4:RemoveDragListener()
			var_90_4:RemoveDragEndListener()
			SLFramework.UGUI.UIClickListener.Get(iter_90_2):RemoveClickListener()
		end
	end

	arg_90_0:_releaseCellList()

	if arg_90_0._dragEffectLoader then
		arg_90_0._dragEffectLoader:dispose()

		arg_90_0._dragEffectLoader = nil
	end

	if arg_90_0._quickLayoutItems then
		for iter_90_3, iter_90_4 in ipairs(arg_90_0._quickLayoutItems) do
			iter_90_4.toggle:RemoveOnValueChanged()
		end
	end
end

return var_0_0
