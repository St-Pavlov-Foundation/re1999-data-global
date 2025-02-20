module("modules.logic.character.view.CharacterTalentChessView", package.seeall)

slot0 = class("CharacterTalentChessView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._goblock = gohelper.findChild(slot0.viewGO, "#go_block")
	slot0._gochessContainer = gohelper.findChild(slot0.viewGO, "chessboard/#go_chessContainer")
	slot0._gomeshContainer = gohelper.findChild(slot0.viewGO, "chessboard/#go_meshContainer")
	slot0._gomeshItem = gohelper.findChild(slot0.viewGO, "chessboard/#go_meshContainer/#go_meshItem")
	slot0._godragAnchor = gohelper.findChild(slot0.viewGO, "chessboard/#go_dragAnchor")
	slot0._godragContainer = gohelper.findChild(slot0.viewGO, "chessboard/#go_dragAnchor/#go_dragContainer")
	slot0._gocellModel = gohelper.findChild(slot0.viewGO, "chessboard/#go_dragAnchor/#go_cellModel")
	slot0._gochessitem = gohelper.findChild(slot0.viewGO, "chessboard/#go_chessitem")
	slot0._goraychessitem = gohelper.findChild(slot0.viewGO, "chessboard/#go_raychessitem")
	slot0._btnroleAttribute = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_roleAttribute")
	slot0._txttalentcn = gohelper.findChildText(slot0.viewGO, "#btn_roleAttribute/#txt_talentcn")
	slot0._txttalentEn = gohelper.findChildText(slot0.viewGO, "#btn_roleAttribute/txtEn")
	slot0._scrollinspiration = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_inspiration")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "#scroll_inspiration/Viewport/#go_Content")
	slot0._goinspirationItem = gohelper.findChild(slot0.viewGO, "#scroll_inspiration/Viewport/#go_Content/#go_inspirationItem")
	slot0._goEmpty = gohelper.findChild(slot0.viewGO, "#scroll_inspiration/Empty")
	slot0._gotip = gohelper.findChild(slot0.viewGO, "#go_tip")
	slot0._gosingleTipsContent = gohelper.findChild(slot0.viewGO, "#go_tip/attributetip/#go_singleTipsContent")
	slot0._gosingleAttributeItem = gohelper.findChild(slot0.viewGO, "#go_tip/attributetip/#go_singleTipsContent/#go_singleAttributeItem")
	slot0._btnclosetipArea = gohelper.findChildButtonWithAudio(slot0.viewGO, "bg/#btn_closetipArea")
	slot0._btntakeoffallcube = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_removeAll")
	slot0._btnrecommend = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_recommend")
	slot0._goupdatetips = gohelper.findChild(slot0.viewGO, "#go_updatetips")
	slot0._goupdatetipscontent = gohelper.findChild(slot0.viewGO, "#go_updatetips/attributetip/#go_updateTipsContent")
	slot0._goupdateattributeitem = gohelper.findChild(slot0.viewGO, "#go_updatetips/attributetip/#go_updateTipsContent/#go_updateAttributeItem")
	slot0._dropresonategroup = gohelper.findChildDropdown(slot0.viewGO, "#drop_resonategroup")
	slot0._txtgroupname = gohelper.findChildText(slot0.viewGO, "#drop_resonategroup/txt_groupname")
	slot0._btnchangetemplatename = gohelper.findChildClickWithAudio(slot0.viewGO, "#drop_resonategroup/#btn_changetemplatename")
	slot0._dropClick = gohelper.getClick(slot0._dropresonategroup.gameObject)
	slot0._gostylechange = gohelper.findChild(slot0.viewGO, "#go_stylechange")
	slot0._txtlabel = gohelper.findChildText(slot0.viewGO, "#go_stylechange/#txt_label")
	slot0._btnstylechange = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_stylechange/#btn_check")
	slot0._goMaxLevel = gohelper.findChild(slot0.viewGO, "#go_check")
	slot0._btnMaxLevel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_check/#btn_check")
	slot0._styleslot = gohelper.findChildImage(slot0.viewGO, "#go_stylechange/slot")
	slot0._styleicon = gohelper.findChildImage(slot0.viewGO, "#go_stylechange/slot/icon")
	slot0._styleglow = gohelper.findChildImage(slot0.viewGO, "#go_stylechange/slot/glow")
	slot0._styleupdate = gohelper.findChild(slot0.viewGO, "#go_stylechange/update")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnchangetemplatename:AddClickListener(slot0._onBtnChangeTemplateName, slot0)
	slot0._btnroleAttribute:AddClickListener(slot0._btnroleAttributeOnClick, slot0)
	slot0._btnclosetipArea:AddClickListener(slot0._btnCloseTipOnClick, slot0)
	slot0._btntakeoffallcube:AddClickListener(slot0._onBtnTakeOffAllCube, slot0)
	slot0._btnrecommend:AddClickListener(slot0._onBtnPutTalentSchemeRequest, slot0)
	slot0._dropresonategroup:AddOnValueChanged(slot0._opDropdownChange, slot0)
	slot0._dropClick:AddClickListener(slot0._onDropClick, slot0)
	slot0._btnstylechange:AddClickListener(slot0._onStyleChangeClick, slot0)
	slot0._btnMaxLevel:AddClickListener(slot0._onMaxLevelClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnchangetemplatename:RemoveClickListener()
	slot0._btnroleAttribute:RemoveClickListener()
	slot0._btnclosetipArea:RemoveClickListener()
	slot0._btntakeoffallcube:RemoveClickListener()
	slot0._btnrecommend:RemoveClickListener()
	slot0._dropresonategroup:RemoveOnValueChanged()
	slot0._dropClick:RemoveClickListener()
	slot0._btnstylechange:RemoveClickListener()
	slot0._btnMaxLevel:RemoveClickListener()
end

function slot0._btnroleAttributeOnClick(slot0)
	CharacterController.instance:openCharacterTalentTipView({
		open_type = 0,
		hero_id = slot0.hero_id
	})
end

function slot0._onBtnTakeOffAllCube(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.TakeOffAllTalentCube, MsgBoxEnum.BoxType.Yes_No, function ()
		uv0:_releaseDragItem()
		HeroRpc.instance:TakeoffAllTalentCubeRequest(uv0.hero_id)
	end)
end

function slot0._btnCloseTipOnClick(slot0)
	if slot0.cur_select_cell_data and gohelper.findChild(slot0._gochessContainer, string.format("%s_%s_%s_%s", slot1.cubeId, slot1.direction, slot1.posX, slot1.posY)) then
		slot2 = slot2.transform
		slot3 = 1.35

		transformhelper.setLocalScale(slot2, slot3, slot3, slot3)
		gohelper.setActive(slot2:Find("icon").gameObject, false)
	end

	slot0.cur_select_cell_data = nil

	gohelper.setActive(slot0._gotip, false)
end

function slot0._editableInitView(slot0)
	gohelper.addChild(slot0.viewGO, slot0._goinspirationItem)
	gohelper.setActive(slot0._goinspirationItem, false)

	slot0._goinspirationItemItem = slot0._goinspirationItem.transform:Find("attributeContent/attributeItem").gameObject
	slot0.bg_ani = gohelper.findChildComponent(slot0.viewGO, "", typeof(UnityEngine.Animator))
	slot0.go_yanwu = gohelper.findChild(slot0.viewGO, "chessboard/yanwu")
	slot0._txtgroupname.text = luaLang("p_charactertalentchessview_txt_groupname")

	gohelper.addUIClickAudio(slot0._btnroleAttribute.gameObject, AudioEnum.UI.play_ui_admission_open)
	gohelper.addUIClickAudio(slot0._btntakeoffallcube.gameObject, AudioEnum.UI.Play_UI_Universal_Click)

	slot0._gomaxselect = gohelper.findChild(slot0.viewGO, "#go_check/#btn_check/selected")
	slot0._gomaxunselect = gohelper.findChild(slot0.viewGO, "#go_check/#btn_check/unselect")
	slot0._leftContentAnim = slot0._goContent:GetComponent(typeof(UnityEngine.Animator))

	slot0:addEventCb(CharacterController.instance, CharacterEvent.RefreshCubeList, slot0._onRefreshCubeList, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.ClickFirstResonanceCellItem, slot0._clickFirstResonanceCellItem, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.ShowGuideDragEffect, slot0._showGuideDragEffect, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.CopyTalentData, slot0._onCopyTalentData, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.UseTalentTemplateReply, slot0._onUseTalentTemplateReply, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.RenameTalentTemplateReply, slot0._onRenameTalentTemplateReply, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.onUseTalentStyleReply, slot0._onUseTalentStyleReply, slot0)
end

function slot0._showGuideDragEffect(slot0, slot1)
	if slot0._dragEffectLoader then
		slot0._dragEffectLoader:dispose()

		slot0._dragEffectLoader = nil
	end

	slot2 = tonumber(slot1) == 1

	gohelper.setActive(slot0._goblock, slot2)

	if slot2 then
		slot0._dragEffectLoader = PrefabInstantiate.Create(slot0.viewGO)

		slot0._dragEffectLoader:startLoad("ui/viewres/guide/guide_character.prefab", slot0._onDragEffectLoaded, slot0)
	end
end

function slot0._onDragEffectLoaded(slot0)
	gohelper.setActive(gohelper.findChild(slot0._dragEffectLoader:getInstGO(), "guide1").gameObject, #(HeroResonanceConfig.instance:getCubeConfig(slot0.own_cube_list[1].id).shape and string.split(slot2.shape, "#") or {}) <= 2)
	gohelper.setActive(gohelper.findChild(slot5, "guide2").gameObject, slot4 >= 3)
end

function slot0._clickFirstResonanceCellItem(slot0)
	for slot4, slot5 in ipairs(slot0._rabbet_cell_list) do
		if slot5.is_filled then
			slot5:clickCube()

			break
		end
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._gotip, false)
	gohelper.setActive(slot0._godragContainer, false)

	slot0.cell_length = 76.2
	slot0.half_length = 38.1

	if type(slot0.viewParam) == "table" then
		slot0.hero_id = slot0.viewParam.hero_id

		if slot0.viewParam.aniPlayIn2 then
			slot0.viewGO:GetComponent(typeof(UnityEngine.Animator)):Play("charactertalentchess_in2", 0, 0)
		end
	else
		slot0.hero_id = slot0.viewParam
	end

	slot0.hero_mo_data = HeroModel.instance:getByHeroId(slot0.hero_id)
	slot0._mainCubeId = slot0.hero_mo_data.talentCubeInfos.own_main_cube_id
	slot0._canPlayCubeAnim = false
	slot0._mainCubeItem = nil

	if not slot0.hero_mo_data then
		print("打印我所拥有的英雄~~~~~~~~~~~~~")

		for slot4, slot5 in pairs(HeroModel.instance._heroId2MODict) do
			print("英雄id：" .. slot5.heroId)
		end

		error("找不到英雄数据~~~~~~~~~~~~~~~~id:" .. slot0.hero_id)

		return
	end

	slot0:_setChessboardData()
	slot0:_setDebrisData()
	TaskDispatcher.runDelay(slot0._playScrollTween, slot0, 0.3)

	slot0._last_add_attr = slot0.hero_mo_data:getTalentGain()

	slot0:_initTemplateList()

	slot0._txttalentcn.text = luaLang("talent_charactertalentlevelup_leveltxt" .. CharacterEnum.TalentTxtByHeroType[slot0.hero_mo_data.config.heroType])
	slot0._txttalentEn.text = luaLang("talent_charactertalentchess_staten" .. CharacterEnum.TalentTxtByHeroType[slot0.hero_mo_data.config.heroType])

	slot0:_refreshStyleTag()

	slot0._showMaxLVBtn = true

	slot0:_showMaxLvBtn()
	slot0:_hideStyleUpdateAnim()
end

function slot0._playScrollTween(slot0)
	if slot0.own_cube_list then
		slot0._goContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = false
		slot0._goContent:GetComponent(gohelper.Type_VerticalLayoutGroup).enabled = false
		slot0.parallel_sequence = slot0.parallel_sequence or FlowParallel.New()

		for slot4, slot5 in ipairs(slot0.own_cube_list) do
			slot6 = slot0._goContent.transform:GetChild(slot4 - 1)
			slot7 = recthelper.getAnchorY(slot6)

			recthelper.setAnchorY(slot6, slot7 - 200)

			slot8 = FlowSequence.New()

			slot8:addWork(WorkWaitSeconds.New(0.03 * (slot4 - 1)))

			slot9 = FlowParallel.New()

			slot9:addWork(TweenWork.New({
				type = "DOAnchorPosY",
				t = 0.35,
				tr = slot6,
				to = slot7,
				ease = EaseType.OutCubic
			}))
			slot9:addWork(TweenWork.New({
				from = 0,
				type = "DOFadeCanvasGroup",
				to = 1,
				t = 0.6,
				go = slot6.gameObject
			}))
			slot8:addWork(slot9)

			if slot4 == #slot0.own_cube_list then
				slot8:addWork(FunctionWork.New(function ()
					uv0._goContent:GetComponent(gohelper.Type_VerticalLayoutGroup).enabled = true
					uv0._goContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = true
				end))
			end

			slot0.parallel_sequence:addWork(slot8)
		end

		slot0.parallel_sequence:start({})
	end
end

function slot0._onRefreshCubeList(slot0)
	if slot0.ignore_refresh_list then
		slot0.ignore_refresh_list = nil

		return
	end

	slot0._goContent:GetComponent(gohelper.Type_VerticalLayoutGroup).enabled = true
	slot0._goContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = true
	slot0._goinspirationItem:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1

	slot0:_setChessboardData()
	slot0:_setDebrisData()

	if slot0.drag_data then
		slot0:_detectDragResult()
	end

	if slot0._last_add_attr then
		slot1 = {}

		for slot6, slot7 in pairs(slot0.hero_mo_data:getTalentGain()) do
			if slot0._last_add_attr[slot7.key] then
				if slot7.value - slot0._last_add_attr[slot7.key].value > 0 then
					if HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(slot7.key)).type == 1 then
						table.insert(slot1, {
							key = slot7.key,
							value = math.floor(slot7.value) - math.floor(slot0._last_add_attr[slot7.key].value)
						})
					else
						table.insert(slot1, {
							key = slot7.key,
							value = slot7.value - slot0._last_add_attr[slot7.key].value
						})
					end
				end
			else
				table.insert(slot1, {
					key = slot7.key,
					value = slot7.value
				})
			end
		end

		slot0:_showAttrTip(slot1)

		slot0._last_add_attr = slot2
	end
end

function slot0._showAttrTip(slot0, slot1)
	table.sort(slot1, function (slot0, slot1)
		return HeroConfig.instance:getIDByAttrType(slot0.key) < HeroConfig.instance:getIDByAttrType(slot1.key)
	end)
	gohelper.CreateObjList(slot0, slot0._showUpdateAttributeTips, slot1, slot0._goupdatetipscontent, slot0._goupdateattributeitem)
	gohelper.setActive(slot0._goupdatetips, true)

	slot0._update_attr_tips_ani = slot0._update_attr_tips_ani or FlowParallel.New()

	slot0._update_attr_tips_ani:destroy()
	slot0._update_attr_tips_ani:ctor()

	for slot6, slot7 in ipairs(slot1) do
		slot8 = slot0._goupdatetipscontent.transform:GetChild(slot6 - 1)
		slot9 = FlowSequence.New()

		slot9:addWork(WorkWaitSeconds.New(0.06 * (slot6 - 1)))
		slot9:addWork(FunctionWork.New(function ()
			gohelper.setActive(uv0.gameObject, true)
		end))
		slot9:addWork(TweenWork.New({
			from = 0,
			type = "DOFadeCanvasGroup",
			to = 1,
			t = 0.2,
			go = slot8.gameObject
		}))
		slot9:addWork(WorkWaitSeconds.New(1))
		slot9:addWork(TweenWork.New({
			from = 1,
			type = "DOFadeCanvasGroup",
			to = 0,
			t = 0.2,
			go = slot8.gameObject
		}))

		if slot6 == #slot1 then
			slot9:addWork(FunctionWork.New(function ()
				gohelper.setActive(uv0._goupdatetips, false)
			end))
		end

		slot0._update_attr_tips_ani:addWork(slot9)
	end

	slot0._update_attr_tips_ani:start({})
end

function slot0._showUpdateAttributeTips(slot0, slot1, slot2, slot3)
	slot4 = slot1.transform
	slot5 = slot4:Find("iconroot/icon"):GetComponent(gohelper.Type_Image)
	slot6 = slot4:Find("name"):GetComponent(gohelper.Type_TextMesh)
	slot7 = slot4:Find("num"):GetComponent(gohelper.Type_TextMesh)

	if HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(slot2.key)).type ~= 1 then
		slot2.value = "+" .. tonumber(string.format("%.3f", slot2.value / 10)) .. "%"
	else
		slot2.value = "+" .. math.floor(slot2.value)
	end

	slot7.text = slot2.value
	slot6.text = slot8.name

	UISpriteSetMgr.instance:setCommonSprite(slot5, "icon_att_" .. slot8.id, true)
	gohelper.setActive(slot1, false)
end

function slot0.getRabbetCell(slot0)
	return slot0._rabbet_cell
end

function slot0._setChessboardData(slot0)
	slot1 = string.splitToNumber(HeroResonanceConfig.instance:getTalentAllShape(slot0.hero_mo_data.heroId, slot0.hero_mo_data.talent), ",")

	if slot0.last_talent_level ~= slot0.hero_mo_data.talent then
		slot0:_releaseCellList()

		slot0._rabbet_cell = {}
		slot0._rabbet_cell_list = {}
		slot2 = 0

		for slot6 = 0, slot1[2] - 1 do
			slot0._rabbet_cell[slot6] = {}

			for slot10 = 0, slot1[1] - 1 do
				slot11 = nil
				slot11 = (slot2 >= slot0._gomeshContainer.transform.childCount or slot0._gomeshContainer.transform:GetChild(slot2)) and gohelper.clone(slot0._gomeshItem, slot0._gomeshContainer)

				recthelper.setAnchor(slot11.transform, (slot10 - (slot1[1] - 1) / 2) * slot0.cell_length, ((slot1[2] - 1) / 2 - slot6) * slot0.cell_length)

				slot0._rabbet_cell[slot6][slot10] = ResonanceCellItem.New(slot11.gameObject, slot10, slot6, slot0)

				table.insert(slot0._rabbet_cell_list, slot0._rabbet_cell[slot6][slot10])

				slot2 = slot2 + 1
			end
		end
	end

	slot0.last_talent_level = slot0.hero_mo_data.talent

	for slot5, slot6 in ipairs(slot0._rabbet_cell_list) do
		slot6.is_filled = false
		slot6.cell_data = nil
	end

	slot0.cube_data = slot0.hero_mo_data.talentCubeInfos.data_list

	slot0:_checkMainCubeNil()
	gohelper.CreateObjList(slot0, slot0._onCubeItemShow, slot0.cube_data, slot0._gochessContainer, slot0._gochessitem)
	slot0:RefreshAllCellLine(true)

	if slot0.effect_showed then
		slot0.effect_showed = nil
		slot0.put_cube_ani = nil
	end

	slot0:_checkAttenuation()
end

function slot0._checkMainCubeNil(slot0)
	if slot0.cube_data then
		for slot4, slot5 in pairs(slot0.cube_data) do
			if slot5.cubeId == slot0._mainCubeId then
				return
			end
		end
	end

	slot0._mainCubeItem = nil
end

function slot0._checkAttenuation(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.cube_data) do
		slot1[slot6.cubeId] = (slot1[slot6.cubeId] or 0) + 1
	end

	for slot5, slot6 in pairs(slot1) do
		if slot6 >= 4 then
			CharacterController.instance:dispatchEvent(CharacterEvent.OnGuideAttenuation)

			return
		end
	end
end

function slot0.playChessIconOutAni(slot0)
	if slot0.cube_data then
		for slot4, slot5 in ipairs(slot0.cube_data) do
			slot0._gochessContainer.transform:GetChild(slot4 - 1):GetComponent(typeof(UnityEngine.Animator)):Play("chessitem_out")
		end
	end
end

function slot0.RefreshAllCellLine(slot0, slot1)
	if slot0._rabbet_cell_list then
		for slot5, slot6 in ipairs(slot0._rabbet_cell_list) do
			slot6:SetNormal(slot1)
		end
	end
end

function slot0.setChessCubeIconAlpha(slot0, slot1)
	if slot0.cube_data then
		for slot5, slot6 in ipairs(slot0.cube_data) do
			if not slot1 then
				slot0._gochessContainer.transform:GetChild(slot5 - 1):GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
			elseif slot6 == slot1 then
				slot7.alpha = 0.5
			end
		end
	end
end

function slot0._onCubeItemShow(slot0, slot1, slot2, slot3)
	slot1.name = string.format("%s_%s_%s_%s", slot2.cubeId, slot2.direction, slot2.posX, slot2.posY)
	slot5 = slot1.transform:GetComponent(gohelper.Type_Image)
	slot7 = gohelper.findChildImage(slot1, "glow")
	slot8 = gohelper.findChildImage(slot1, "cell")
	slot9 = slot1:GetComponent(typeof(UnityEngine.Animator))
	slot11 = slot0:_rotationMatrix(HeroResonanceConfig.instance:getCubeMatrix(slot2.cubeId), slot2.direction)

	if slot0.cur_select_cell_data then
		if slot0.cur_select_cell_data.cubeId ~= slot2.cubeId or slot0.cur_select_cell_data.direction ~= slot2.direction or slot0.cur_select_cell_data.posX ~= slot2.posX or slot0.cur_select_cell_data.posY ~= slot2.posY then
			gohelper.setActive(gohelper.findChildImage(slot1, "icon").gameObject, slot0._mainCubeId == slot2.cubeId)
			transformhelper.setLocalScale(slot4, 1.35, 1.35, 1.35)
		end
	else
		gohelper.setActive(slot6.gameObject, slot12)
		transformhelper.setLocalScale(slot4, 1.35, 1.35, 1.35)
	end

	UISpriteSetMgr.instance:setCharacterTalentSprite(slot5, "ky_" .. HeroResonanceConfig.instance:getCubeConfig(slot2.cubeId).icon, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(slot6, HeroResonanceConfig.instance:getCubeConfig(slot2.cubeId).icon, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(slot7, "glow_" .. HeroResonanceConfig.instance:getCubeConfig(slot2.cubeId).icon, true)
	transformhelper.setLocalRotation(slot4, 0, 0, -slot2.direction * 90)

	slot15 = slot0.cell_length * GameUtil.getTabLen(slot10[0])
	slot16 = slot0.cell_length * GameUtil.getTabLen(slot10)
	slot17 = slot2.direction % 2 == 0

	recthelper.setAnchor(slot4, slot0._rabbet_cell[slot2.posY][slot2.posX].transform.anchoredPosition.x + (slot17 and slot15 or slot16) / 2 - slot0.half_length, slot0._rabbet_cell[slot2.posY][slot2.posX].transform.anchoredPosition.y + -(slot17 and slot16 or slot15) / 2 + slot0.half_length)

	slot18 = {}
	slot20 = GameUtil.getTabLen(slot11[0]) - 1

	for slot24 = 0, GameUtil.getTabLen(slot11) - 1 do
		for slot28 = 0, slot20 do
			if slot11[slot24][slot28] == 1 then
				table.insert(slot18, {
					slot2.posX + slot28,
					slot2.posY + slot24
				})
			end
		end
	end

	for slot24, slot25 in ipairs(slot18) do
		slot0._rabbet_cell[slot25[2]][slot25[1]].is_filled = true

		slot0._rabbet_cell[slot25[2]][slot25[1]]:setCellData(slot2)
	end

	if slot12 then
		if not slot0._mainCubeItem and slot0._isCanPlaySwitch then
			slot9:Play("chessitem_switch", 0, 0)

			slot0._isCanPlaySwitch = false
		end

		slot0._mainCubeItem = {
			bg = slot5,
			icon = slot6,
			glow_icon = slot7,
			cell_icon = slot8,
			anim = slot9
		}

		slot0:_refreshMainStyleCubeItem()
		gohelper.setActive(slot6.gameObject, true)
	else
		gohelper.setActive(slot8.gameObject, false)
	end
end

function slot0._refreshMainStyleCubeItem(slot0)
	slot1 = HeroResonanceConfig.instance:getCubeConfig(slot0._mainCubeId).icon
	slot2 = "ky_" .. slot1
	slot3 = slot1
	slot4 = "glow_" .. slot1
	slot5 = string.split(slot1, "_")
	slot6 = "gz_" .. slot5[#slot5]
	slot7 = slot0.hero_mo_data:getHeroUseStyleCubeId()
	slot8 = HeroResonanceConfig.instance:getCubeConfig(slot7)

	if not (slot7 == slot0._mainCubeId) and slot8 and not string.nilorempty(slot8.icon) then
		slot2 = "ky_" .. slot10
		slot4 = "mk_" .. slot10
	end

	if slot0.drag_dic_image and slot0.drag_dic_image[slot0._mainCubeId] then
		UISpriteSetMgr.instance:setCharacterTalentSprite(slot10:GetComponent(gohelper.Type_Image), slot3, true)
	end

	if slot0._mainCubeItem then
		UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._mainCubeItem.bg, slot2, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._mainCubeItem.icon, slot3, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._mainCubeItem.glow_icon, slot4, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._mainCubeItem.cell_icon, slot6, true)
		gohelper.setActive(slot0._mainCubeItem.cell_icon.gameObject, not slot9)
	end
end

function slot0._rotationMatrix(slot0, slot1, slot2)
	slot3 = slot1

	while slot2 > 0 do
		slot3 = {
			[slot9] = {}
		}
		slot4 = GameUtil.getTabLen(slot1)

		for slot9 = 0, GameUtil.getTabLen(slot1[0]) - 1 do
			for slot13 = 0, slot4 - 1 do
				slot3[slot9][slot13] = slot1[slot4 - slot13 - 1][slot9]
			end
		end

		if slot2 - 1 > 0 then
			slot1 = slot3
		end
	end

	return slot3
end

function slot0._setDebrisData(slot0)
	slot1 = slot0.hero_mo_data.talentCubeInfos.own_cube_list
	slot0.own_cube_list = slot1

	table.sort(slot1, function (slot0, slot1)
		return HeroResonanceConfig.instance:getCubeConfig(slot0.id).sort < HeroResonanceConfig.instance:getCubeConfig(slot1.id).sort
	end)

	slot0._cubeRoot = slot0:getUserDataTb_()

	gohelper.CreateObjList(slot0, slot0._onDebrisItemShow, slot1, slot0._goContent, slot0._goinspirationItem)
	gohelper.setActive(slot0._goEmpty, #slot1 == 0)
	gohelper.setActive(slot0._goMaxLevel, #slot1 > 0)
	gohelper.setActive(slot0._gostylechange, TalentStyleModel.instance:isUnlockStyleSystem(slot0.hero_mo_data.talent))
end

function slot0._onDebrisItemShow(slot0, slot1, slot2, slot3)
	slot4 = slot1.transform
	slot1.name = slot3
	slot5 = slot4:Find("item/slot"):GetComponent(gohelper.Type_Image)

	SLFramework.UGUI.UIDragListener.Get(slot5.gameObject):AddDragBeginListener(slot0._onDragBegin, slot0, slot2.id)
	SLFramework.UGUI.UIDragListener.Get(slot5.gameObject):AddDragListener(slot0._onDrag, slot0)
	SLFramework.UGUI.UIDragListener.Get(slot5.gameObject):AddDragEndListener(slot0._onDragEnd, slot0)
	SLFramework.UGUI.UIClickListener.Get(slot5.gameObject):AddClickDownListener(slot0._onClickDownHandler, slot0)
	recthelper.setAnchorX(slot4:Find("item/slot/countbg").transform, 3.4 - 56 * HeroResonanceConfig.instance:getLastRowfulPos(slot2.id))

	slot4:Find("item/slot/countbg/count"):GetComponent(gohelper.Type_TextMesh).text = slot2.own
	slot4:Find("level/level"):GetComponent(gohelper.Type_TextMesh).text = "Lv." .. slot2.level
	slot0._cubeRoot[slot2.id] = slot0._cubeRoot[slot2.id] or {
		root = slot4:Find("attributeContent").gameObject,
		item = slot4:Find("attributeContent/attributeItem").gameObject,
		levelTxt = slot10,
		Icon = slot4:Find("item/slot/icon"):GetComponent(gohelper.Type_Image),
		glow_icon = slot4:Find("item/slot/glow"):GetComponent(gohelper.Type_Image),
		cell_bg = slot5,
		countbg = slot7,
		anim = slot1:GetComponent(typeof(UnityEngine.Animator))
	}

	slot0:_refreshAttrItem(slot2.id)
	gohelper.setActive(slot4:Find("stylebg"), slot0._mainCubeId == slot2.id)
end

function slot0._refreshAttrItem(slot0, slot1, slot2)
	if not slot0._cubeRoot then
		return
	end

	slot3 = slot0._cubeRoot[slot1].root
	slot4 = slot0._cubeRoot[slot1].item
	slot5 = slot0._cubeRoot[slot1].levelTxt
	slot6 = slot0._cubeRoot[slot1].anim
	slot7 = slot0.hero_mo_data:getCurTalentLevelConfig(slot1)
	slot8 = {}
	slot13 = slot8

	slot0.hero_mo_data:getTalentStyleCubeAttr(slot1, slot13, slot14, nil, slot2)

	slot9 = {}

	for slot13, slot14 in pairs(slot8) do
		table.insert(slot9, {
			key = slot13,
			value = slot14,
			is_special = slot7.calculateType == 1,
			config = slot7
		})
	end

	table.sort(slot9, function (slot0, slot1)
		return HeroConfig.instance:getIDByAttrType(slot0.key) < HeroConfig.instance:getIDByAttrType(slot1.key)
	end)

	slot10 = HeroResonanceConfig.instance:getCubeConfig(slot1).icon
	slot11 = "glow_" .. slot10
	slot12 = string.split(slot10, "_")

	if slot0:getMainStyleCube(slot1) and HeroResonanceConfig.instance:getCubeConfig(slot14) then
		slot11 = "mk_" .. slot15.icon
		slot13 = "gz_" .. slot12[#slot12] .. "_2"
	end

	function slot15()
		uv0.text = "Lv." .. (uv1 or uv2.level)

		gohelper.CreateObjList(uv3, uv3._onDebrisAttrItemShow, uv4, uv5, uv6)
		UISpriteSetMgr.instance:setCharacterTalentSprite(uv3._cubeRoot[uv7].Icon, uv8, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(uv3._cubeRoot[uv7].glow_icon, uv9, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(uv3._cubeRoot[uv7].cell_bg, uv10, true)

		if uv1 == nil and not uv3._showMaxLVBtn then
			uv3._showMaxLVBtn = true

			uv3:_showMaxLvBtn()
		end
	end

	if slot1 == slot0._mainCubeId and slot2 == nil and slot0._canPlayCubeAnim then
		TaskDispatcher.cancelTask(slot15, slot0)
		slot6:Play("switch", 0, 0)
		TaskDispatcher.runDelay(slot15, slot0, 0.16)

		slot0._canPlayCubeAnim = false
	else
		slot15()
	end
end

function slot0._onDebrisAttrItemShow(slot0, slot1, slot2, slot3)
	slot4 = slot1.transform
	slot7 = slot4:Find("name/num"):GetComponent(gohelper.Type_TextMesh)
	slot8 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(slot2.key))
	slot4:Find("name"):GetComponent(gohelper.Type_TextMesh).text = slot8.name

	UISpriteSetMgr.instance:setCommonSprite(slot4:Find("icon"):GetComponent(gohelper.Type_Image), "icon_att_" .. slot8.id)

	if slot8.type ~= 1 then
		slot2.value = slot2.value / 10 .. "%"
	elseif not slot2.is_special then
		slot2.value = slot2.config[slot2.key] / 10 .. "%"
	else
		slot2.value = math.floor(slot2.value)
	end

	slot7.text = "+" .. slot2.value
end

function slot0.showCurSelectCubeAttr(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)
	gohelper.setActive(slot0._gotip, true)

	slot2 = {}

	slot0.hero_mo_data:getTalentStyleCubeAttr(slot1.cubeId, slot2)

	slot3 = {}
	slot4 = slot0.hero_mo_data:getCurTalentLevelConfig(slot1.cubeId)

	for slot8, slot9 in pairs(slot2) do
		table.insert(slot3, {
			key = slot8,
			value = slot9,
			is_special = slot4.calculateType == 1,
			config = slot4
		})
	end

	table.sort(slot3, function (slot0, slot1)
		return HeroConfig.instance:getIDByAttrType(slot0.key) < HeroConfig.instance:getIDByAttrType(slot1.key)
	end)
	table.insert(slot3, 1, {})
	gohelper.CreateObjList(slot0, slot0._onShowSingleCubeAttrTips, slot3, slot0._gosingleTipsContent, slot0._gosingleAttributeItem)

	if gohelper.findChild(slot0._gochessContainer, string.format("%s_%s_%s_%s", slot1.cubeId, slot1.direction, slot1.posX, slot1.posY)) then
		slot5 = slot5.transform
		slot6 = 1.45

		transformhelper.setLocalScale(slot5, slot6, slot6, slot6)
		gohelper.setActive(slot5:Find("icon").gameObject, true)
	end
end

function slot0._onShowSingleCubeAttrTips(slot0, slot1, slot2, slot3)
	if slot3 ~= 1 then
		slot4 = slot1.transform
		slot7 = slot4:Find("num"):GetComponent(gohelper.Type_TextMesh)
		slot8 = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(slot2.key))
		slot4:Find("name"):GetComponent(gohelper.Type_TextMesh).text = slot8.name

		UISpriteSetMgr.instance:setCommonSprite(slot4:Find("icon"):GetComponent(gohelper.Type_Image), "icon_att_" .. slot8.id)

		if slot8.type ~= 1 then
			slot2.value = slot2.value / 10 .. "%"
		elseif not slot2.is_special then
			slot2.value = slot2.config[slot2.key] / 10 .. "%"
		else
			slot2.value = math.floor(slot2.value)
		end

		slot7.text = slot2.value
	end
end

function slot0._onContainerDragBegin(slot0, slot1, slot2)
	slot0:_btnCloseTipOnClick()

	slot0.is_draging = true
	slot3 = recthelper.screenPosToAnchorPos(slot2.position, slot0._gomeshContainer.transform)
	slot4, slot5 = recthelper.getAnchor(slot0.drag_container_transform)
	slot0.drag_offset_x = slot4 - slot3.x
	slot0.drag_offset_y = slot5 - slot3.y
end

function slot0._onContainerDrag(slot0, slot1, slot2)
	if not slot0.drag_data then
		return
	end

	recthelper.setAnchor(slot0.drag_container_transform, recthelper.screenPosToAnchorPos(slot2.position, slot0._gomeshContainer.transform).x + (slot0.drag_offset_x or 0), slot3.y + (slot0.drag_offset_y or 0))
	slot0:_detectDragResult()
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0:_btnCloseTipOnClick()

	if slot0.recover_data then
		slot0:_setChessboardData()

		slot0.cur_drag_is_get = nil
		slot0.recover_data = nil
	end

	slot0:_createDragItem(slot1)
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot0.drag_data then
		return
	end

	slot3 = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), slot0._gomeshContainer.transform)

	recthelper.setAnchor(slot0.drag_container_transform, slot3.x, slot3.y)
	slot0:_detectDragResult()
end

function slot0._detectDragResult(slot0)
	slot0.cur_fill_count = 0
	slot0.cross_point = false

	slot0:setChessCubeIconAlpha()

	for slot4, slot5 in ipairs(slot0._rabbet_cell_list) do
		slot5:SetNormal()

		slot10 = slot0.drag_data.drag_id

		for slot10, slot11 in ipairs(slot0.drag_cube_child_list[slot10]) do
			slot12 = slot11.transform
			slot13 = recthelper.getAnchorX(slot12)
			slot14 = recthelper.getAnchorY(slot12)
			slot15 = -slot0.drag_data.direction * 90

			if slot6:detectPosCover(recthelper.getAnchorX(slot0.drag_container_transform) + slot13 * math.cos(math.rad(slot15)) - slot14 * math.sin(math.rad(slot15)), recthelper.getAnchorY(slot0.drag_container_transform) + slot13 * math.sin(math.rad(slot15)) + slot14 * math.cos(math.rad(slot15))) then
				if slot11.rightful then
					if slot6.is_filled then
						slot6:SetRed()

						if slot0.setChessCubeIconAlpha then
							slot0:setChessCubeIconAlpha(slot6.cell_data)
						end
					else
						slot0.cur_fill_count = slot0.cur_fill_count + 1
					end
				end

				if slot0.drag_cube_top_left_child == slot12 then
					slot0.adsorbent_pos_x = slot6.pos_x
					slot0.adsorbent_pos_y = slot6.pos_y
				end

				slot0.cross_point = true
				slot0.release_offset_x = slot6.position_x - slot16
				slot0.release_offset_y = slot6.position_y - slot17
			end
		end
	end

	if slot0.cur_fill_count == HeroResonanceConfig.instance:getCubeRightful(slot0.drag_data.drag_id) then
		slot2 = GameUtil.getTabLen(slot0.cur_matrix[0]) - 1
		slot3 = slot0.adsorbent_pos_x
		slot4 = slot0.adsorbent_pos_y

		for slot8 = 0, GameUtil.getTabLen(slot0.cur_matrix) - 1 do
			for slot12 = 0, slot2 do
				if slot0.cur_matrix[slot8][slot12] == 1 then
					if not slot0._rabbet_cell[slot4 + slot8][slot3 + slot12] then
						logError(slot12, slot8, slot3, slot4)
					end

					if not slot0.cur_matrix[slot8 - 1] or slot0.cur_matrix[slot8 - 1][slot12] ~= 1 then
						slot0._rabbet_cell[slot4 + slot8][slot3 + slot12]:lightTop()
					end

					if not slot0.cur_matrix[slot8][slot12 + 1] or slot0.cur_matrix[slot8][slot12 + 1] ~= 1 then
						slot0._rabbet_cell[slot4 + slot8][slot3 + slot12]:lightRight()
					end

					if not slot0.cur_matrix[slot8 + 1] or slot0.cur_matrix[slot8 + 1][slot12] ~= 1 then
						slot0._rabbet_cell[slot4 + slot8][slot3 + slot12]:lightBottom()
					end

					if not slot0.cur_matrix[slot8][slot12 - 1] or slot0.cur_matrix[slot8][slot12 - 1] ~= 1 then
						slot0._rabbet_cell[slot4 + slot8][slot3 + slot12]:lightLeft()
					end

					if slot0.cur_matrix[slot8 - 1] and slot0.cur_matrix[slot8 - 1][slot12] == 1 then
						slot0._rabbet_cell[slot4 + slot8][slot3 + slot12]:hideTop()
					end

					if slot0.cur_matrix[slot8][slot12 + 1] == 1 then
						slot0._rabbet_cell[slot4 + slot8][slot3 + slot12]:hideRight()
					end

					if slot0.cur_matrix[slot8 + 1] and slot0.cur_matrix[slot8 + 1][slot12] == 1 then
						slot0._rabbet_cell[slot4 + slot8][slot3 + slot12]:hideBottom()
					end

					if slot0.cur_matrix[slot8][slot12 - 1] == 1 then
						slot0._rabbet_cell[slot4 + slot8][slot3 + slot12]:hideLeft()
					end
				end
			end
		end
	end
end

function slot0._onDragEnd(slot0, slot1, slot2)
	slot0.is_draging = false
	slot0.recover_data = nil

	if not slot0.drag_data then
		slot0:_releaseDragItem()

		slot0.cur_fill_count = 0

		return
	end

	if slot0._dragEffectLoader and slot0.cur_fill_count < 2 then
		slot0.cur_fill_count = 0
		slot0.cross_point = nil
	end

	if slot0.cur_fill_count == HeroResonanceConfig.instance:getCubeRightful(slot0.drag_data.drag_id) then
		slot0.ignore_refresh_list = slot0.cur_drag_is_get

		slot0:releaseFromChess()

		slot0.put_cube_ani = slot0.drag_data
		slot0.drag_data.posX = slot0.adsorbent_pos_x
		slot0.drag_data.posY = slot0.adsorbent_pos_y

		if slot0.cur_select_cell_data then
			slot0.cur_select_cell_data.cubeId = slot0.put_cube_ani.drag_id
			slot0.cur_select_cell_data.posX = slot0.drag_data.posX
			slot0.cur_select_cell_data.posY = slot0.drag_data.posY
			slot0.cur_select_cell_data.direction = slot0.drag_data.direction

			slot0:requestPutCube()

			slot0.cur_fill_count = 0

			return
		end

		slot4 = slot0._rabbet_cell[slot0.adsorbent_pos_y][slot0.adsorbent_pos_x].transform:InverseTransformPoint(slot0.drag_cube_top_left_child.position)
		slot0._put_ani_flow = slot0._put_ani_flow or FlowParallel.New()

		slot0._put_ani_flow:destroy()
		slot0._put_ani_flow:ctor()
		slot0._put_ani_flow:addWork(TweenWork.New({
			type = "DOAnchorPos",
			t = 0.1,
			tr = slot0.drag_container_transform,
			tox = recthelper.getAnchorX(slot0.drag_container_transform) - slot4.x,
			toy = recthelper.getAnchorY(slot0.drag_container_transform) - slot4.y,
			ease = EaseType.InCubic
		}))
		slot0._put_ani_flow:addWork(TweenWork.New({
			toz = 1,
			type = "DOScale",
			tox = 1.35,
			toy = 1.35,
			t = 0.1,
			tr = slot0.drag_dic_image[slot0.drag_data.drag_id],
			ease = EaseType.InCubic
		}))
		slot0._put_ani_flow:registerDoneListener(slot0.onPutAniDone, slot0)

		if slot0._rabbet_cell_list then
			for slot8, slot9 in ipairs(slot0._rabbet_cell_list) do
				slot9:hideEmptyBg()
			end
		end

		slot0.drag_data = nil

		slot0._put_ani_flow:start()
	elseif slot0.cross_point then
		AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_property_fail)
		recthelper.setAnchor(slot0.drag_container_transform, recthelper.getAnchorX(slot0.drag_container_transform) + slot0.release_offset_x, recthelper.getAnchorY(slot0.drag_container_transform) + slot0.release_offset_y)

		if slot0.cur_drag_is_get then
			slot0.recover_data = {
				drag_id = slot0.drag_data.drag_id,
				initial_direction = slot0.drag_data.initial_direction,
				posX = slot0.drag_data.posX,
				posY = slot0.drag_data.posY
			}
		end
	else
		slot0:releaseFromChess()
		AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_property_click)
		slot0:_releaseDragItem()
	end

	slot0.cur_fill_count = 0
end

function slot0.releaseFromChess(slot0)
	if slot0.cur_drag_is_get then
		if slot0.drag_data.drag_id and slot0.drag_data.initial_direction and slot0.drag_data.posX and slot0.drag_data.posY then
			HeroRpc.instance:PutTalentCubeRequest(slot0.hero_mo_data.heroId, HeroResonanceEnum.GetCube, slot0.drag_data.drag_id, slot0.drag_data.initial_direction, slot0.drag_data.posX, slot0.drag_data.posY)
		else
			slot0:_onRefreshCubeList()
		end
	end

	slot0.cur_drag_is_get = nil
end

function slot0._onClickDownHandler(slot0)
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_property_click)
end

function slot0.onPutAniDone(slot0)
	slot0._put_ani_flow:unregisterDoneListener(slot0.onPutAniDone, slot0)

	slot0.drag_data = slot0.put_cube_ani

	slot0:requestPutCube()
end

function slot0.requestPutCube(slot0)
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_property_success)
	HeroRpc.instance:PutTalentCubeRequest(slot0.hero_mo_data.heroId, HeroResonanceEnum.PutCube, slot0.drag_data.drag_id, slot0.drag_data.direction, slot0.adsorbent_pos_x, slot0.adsorbent_pos_y)
	slot0:_releaseDragItem()
end

function slot0._releaseDragItem(slot0)
	slot0.cross_point = false

	if slot0.drag_data then
		gohelper.setActive(slot0.drag_container_transform:Find(slot0.drag_data.drag_id).gameObject, false)
	end

	slot0.drag_data = nil

	slot0:RefreshAllCellLine()
	gohelper.setActive(slot0.drag_container, false)
end

function slot0._createDragItem(slot0, slot1, slot2, slot3, slot4)
	if slot0._dragEffectLoader and slot1 ~= 18 then
		return
	end

	if not slot0.drag_container then
		slot0.drag_container = slot0._godragContainer
		slot0.drag_container_transform = slot0.drag_container.transform
		slot0._dragContainerDragCom = SLFramework.UGUI.UIDragListener.Get(slot0.drag_container)

		slot0._dragContainerDragCom:AddDragBeginListener(slot0._onContainerDragBegin, slot0)
		slot0._dragContainerDragCom:AddDragListener(slot0._onContainerDrag, slot0)
		slot0._dragContainerDragCom:AddDragEndListener(slot0._onDragEnd, slot0)
		SLFramework.UGUI.UIClickListener.Get(slot0.drag_container):AddClickListener(slot0._rotateCube, slot0)
	end

	transformhelper.setLocalRotation(slot0.drag_container_transform, 0, 0, 0)

	slot5 = slot0.drag_container_transform:Find(slot1) or gohelper.clone(slot0._gocellModel, slot0.drag_container, slot1)

	gohelper.setActive(slot0.drag_container, true)

	if slot0.drag_data then
		gohelper.setActive(slot0.drag_container_transform:Find(slot0.drag_data.drag_id).gameObject, false)
	else
		slot0.drag_data = {}
	end

	slot0.drag_data.drag_id = slot1
	slot0.drag_data.direction = slot2 or 0
	slot0.drag_data.initial_direction = slot2 or 0
	slot6 = slot5.gameObject

	if not slot0.drag_cube_child_list then
		slot0.drag_cube_child_list = {}
	end

	if not slot0.drag_cube_child_list[slot1] then
		slot0.drag_cube_child_list[slot1] = {}

		slot0:_createDragCubeChild(slot0.drag_cube_child_list[slot1], slot1, slot6)
	end

	slot7 = 1.45

	transformhelper.setLocalScale(slot0.drag_dic_image[slot0.drag_data.drag_id], slot7, slot7, 1)
	gohelper.setActive(slot6, true)
	slot0:_setTopLeftTarget()
end

function slot0._createDragCubeChild(slot0, slot1, slot2, slot3)
	slot4 = slot0:_rotationMatrix(HeroResonanceConfig.instance:getCubeMatrix(slot2), 0)
	slot6 = GameUtil.getTabLen(slot4[0]) - 1
	slot7 = 0
	slot8 = 0

	for slot12 = 0, GameUtil.getTabLen(slot4) - 1 do
		for slot16 = 0, slot6 do
			if slot4[slot12][slot16] == 1 and slot16 <= slot7 then
				slot7 = slot16

				if slot8 <= slot12 then
					slot8 = slot12
				end
			end
		end
	end

	slot9 = nil

	if not slot0.drag_cube_origin_mat then
		slot0.drag_cube_origin_mat = {}
	end

	if not slot0.drag_cube_origin_mat[slot2] then
		slot0.drag_cube_origin_mat[slot2] = {}
	end

	for slot13 = 0, slot5 do
		slot0.drag_cube_origin_mat[slot2][slot13] = {}

		for slot17 = 0, slot6 do
			slot18 = slot0:getUserDataTb_()
			slot18.gameObject = gohelper.clone(slot0._gocellModel, slot3)
			slot18.transform = slot18.gameObject.transform
			slot18.rightful = slot4[slot13][slot17] == 1

			recthelper.setAnchor(slot18.gameObject.transform, (slot17 - slot7) * slot0.cell_length, (slot8 - slot13) * slot0.cell_length)

			slot0.drag_cube_origin_mat[slot2][slot13][slot17] = slot18.gameObject

			table.insert(slot1, slot18)

			if slot13 == 0 and slot17 == 0 then
				slot21 = gohelper.clone(slot0._goraychessitem, slot18.gameObject)

				gohelper.setActive(slot21, true)

				slot9 = slot21:GetComponent(gohelper.Type_Image)
				slot22 = HeroResonanceConfig.instance:getCubeConfig(slot2).icon

				if slot0:getMainStyleCube(slot2) and HeroResonanceConfig.instance:getCubeConfig(slot23) then
					slot22 = "mk_" .. slot24.icon
				end

				UISpriteSetMgr.instance:setCharacterTalentSprite(slot9, slot22, true)
				recthelper.setAnchor(slot21.transform, slot0.cell_length * GameUtil.getTabLen(slot4[0]) / 2 - slot0.half_length, -(slot0.cell_length * GameUtil.getTabLen(slot4) / 2) + slot0.half_length)

				if not slot0.drag_image then
					slot0.drag_image = slot0:getUserDataTb_()
				end

				if not slot0.drag_dic_image then
					slot0.drag_dic_image = slot0:getUserDataTb_()
				end

				SLFramework.UGUI.UIDragListener.Get(slot21):AddDragBeginListener(slot0._onContainerDragBegin, slot0)
				SLFramework.UGUI.UIDragListener.Get(slot21):AddDragListener(slot0._onContainerDrag, slot0)
				SLFramework.UGUI.UIDragListener.Get(slot21):AddDragEndListener(slot0._onDragEnd, slot0)
				SLFramework.UGUI.UIClickListener.Get(slot21):AddClickListener(slot0._rotateCube, slot0)
				table.insert(slot0.drag_image, slot21)

				slot0.drag_dic_image[slot2] = slot21.transform
			end
		end
	end
end

function slot0.getMainStyleCube(slot0, slot1)
	if slot1 == slot0._mainCubeId and slot0.hero_mo_data:getHeroUseStyleCubeId() ~= slot0._mainCubeId then
		return slot2
	end
end

function slot0._setTopLeftTarget(slot0)
	slot0.drag_cube_top_left_child = slot0:_rotationMatrix(slot0.drag_cube_origin_mat[slot0.drag_data.drag_id], slot0.drag_data.direction)[0][0].transform
	slot0.cur_matrix = slot0:_rotationMatrix(HeroResonanceConfig.instance:getCubeMatrix(slot0.drag_data.drag_id), slot0.drag_data.direction)
end

function slot0._onGetCube(slot0, slot1)
	if slot0.recover_data then
		if slot0.recover_data.drag_id ~= slot1.cubeId or slot0.recover_data.direction ~= slot1.direction or slot0.recover_data.posX ~= slot1.posX or slot0.recover_data.posY ~= slot1.posY then
			if slot0._rabbet_cell_list then
				for slot5, slot6 in ipairs(slot0._rabbet_cell_list) do
					slot6:hideEmptyBg()
				end
			end

			slot0:_setChessboardData()
		end

		slot0.cur_drag_is_get = nil
		slot0.recover_data = nil
	end

	if slot0._rabbet_cell_list then
		for slot5, slot6 in ipairs(slot0._rabbet_cell_list) do
			if slot6.cell_data == slot1 then
				slot6.is_filled = false
			end
		end
	end

	slot0.cur_fill_count = 0

	slot0:_createDragItem(slot1.cubeId, slot1.direction, slot1.posX, slot1.posY)
	transformhelper.setLocalRotation(slot0.drag_container_transform, 0, 0, -slot0.drag_data.direction * 90)
	slot0:_setTopLeftTarget()

	slot2 = slot0._rabbet_cell[slot1.posY][slot1.posX]

	recthelper.setAnchor(slot0.drag_container_transform, slot2.position_x, slot2.position_y)

	slot3 = slot0.drag_container_transform.parent.transform:InverseTransformPoint(slot0.drag_cube_top_left_child.position)

	gohelper.setActive(slot0._gochessContainer.transform:Find(string.format("%s_%s_%s_%s", slot1.cubeId, slot1.direction, slot1.posX, slot1.posY)).gameObject, false)
	recthelper.setAnchor(slot0.drag_container_transform, slot2.position_x + slot2.position_x - slot3.x, slot2.position_y + slot2.position_y - slot3.y)

	slot0.cur_drag_is_get = true
	slot0.drag_data.posX = slot1.posX
	slot0.drag_data.posY = slot1.posY

	slot0:RefreshAllCellLine()
end

function slot0.onCubeClick(slot0, slot1)
	slot0:_onGetCube(slot1)
	slot0:_rotateCube()
end

function slot0._rotateCube(slot0)
	if slot0.is_draging then
		return
	end

	if not slot0.drag_data then
		return
	end

	slot0.drag_data.direction = slot0.drag_data.direction + 1 > 3 and 0 or slot1

	if slot0.cur_select_cell_data then
		slot0.cur_select_cell_data.direction = slot0.drag_data.direction
	end

	transformhelper.setLocalRotation(slot0.drag_container_transform, 0, 0, -slot0.drag_data.direction * 90)
	slot0:_setTopLeftTarget()
	slot0:_detectDragResult()
	slot0:_onDragEnd()
end

function slot0.onClose(slot0)
end

function slot0._releaseCellList(slot0)
	if slot0._rabbet_cell_list then
		for slot4, slot5 in ipairs(slot0._rabbet_cell_list) do
			slot5:releaseSelf()
		end

		slot0._rabbet_cell_list = nil
	end
end

function slot0._onBtnPutTalentSchemeRequest(slot0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.PutTalent) then
		GuideModel.instance:setFlag(GuideModel.GuideFlag.PutTalent, nil)
		slot0:_putTalentSchemeRequest()

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.RecommendTalentChess, MsgBoxEnum.BoxType.Yes_No, function ()
		uv0:_putTalentSchemeRequest()
	end)
end

function slot0._putTalentSchemeRequest(slot0)
	slot0:_releaseOperation()

	slot1 = HeroResonanceConfig.instance:getTalentConfig(slot0.hero_mo_data.heroId, slot0.hero_mo_data.talent)

	HeroRpc.instance:PutTalentSchemeRequest(slot0.hero_mo_data.heroId, slot0.hero_mo_data.talent, slot1.talentMould, string.splitToNumber(slot1.exclusive, "#")[1])
end

function slot0._initTemplateList(slot0)
	table.sort(slot0.hero_mo_data.talentTemplates, uv0.sortTemplate)

	slot1 = luaLang("talent_charactertalentchess_template" .. CharacterEnum.TalentTxtByHeroType[slot0.hero_mo_data.config.heroType])
	slot2 = {}

	for slot7, slot8 in ipairs(slot0.hero_mo_data.talentTemplates) do
		slot9 = nil

		if TalentStyleModel.instance:isUnlockStyleSystem(slot0.hero_mo_data.talent) and not string.nilorempty(TalentStyleModel.instance:getTalentStyle(slot0._mainCubeId, slot8.style) and slot10._styleCo and slot10._styleCo.tagicon) then
			slot9 = string.format("<sprite=%s>", tonumber(slot11) - 1) .. (LangSettings.instance:isEn() and (string.nilorempty(slot8.name) and slot1 .. " " .. slot7 or slot8.name) or string.nilorempty(slot8.name) and slot1 .. slot7 or slot8.name)
		end

		table.insert(slot2, slot9)

		if slot8.id == slot0.hero_mo_data.useTalentTemplateId then
			slot0._curSelectTemplateIndex = slot7
			slot0._txtgroupname.text = slot9
		end
	end

	slot0._dropresonategroup:ClearOptions()
	slot0._dropresonategroup:AddOptions(slot2)
	slot0._dropresonategroup:SetValue(slot0._curSelectTemplateIndex - 1)

	slot0._templateInitDone = true
end

function slot0._opDropdownChange(slot0, slot1)
	if not slot0._templateInitDone then
		return
	end

	if slot0._curSelectTemplateIndex ~= (slot1 or 0) + 1 then
		slot0._curSelectTemplateIndex = slot2

		HeroRpc.instance:UseTalentTemplateRequest(slot0.hero_mo_data.heroId, slot0.hero_mo_data.talentTemplates[slot2].id)
	end
end

function slot0._releaseOperation(slot0)
	slot0:_btnCloseTipOnClick()
	slot0:_releaseDragItem()
	slot0:setChessCubeIconAlpha()
end

function slot0._onUseTalentTemplateReply(slot0)
	slot0._isCanPlaySwitch = true
	slot0._mainCubeItem = nil

	slot0:_chooseOtherStyleOrTemplate()
	slot0:_showTemplateName()
end

function slot0._playMainCubeSwitchAnim(slot0)
	if slot0._mainCubeItem and slot0._isCanPlaySwitch then
		slot0._mainCubeItem.anim:Play("chessitem_switch", 0, 0)

		slot0._isCanPlaySwitch = false
	end
end

function slot0._chooseOtherStyleOrTemplate(slot0)
	slot0:_releaseOperation()
	slot0:_refreshStyleTag()
	slot0:_refreshMainStyleCubeItem()
	TaskDispatcher.cancelTask(slot0._hideStyleUpdateAnim, slot0)
	gohelper.setActive(slot0._styleupdate, true)
	TaskDispatcher.runDelay(slot0._hideStyleUpdateAnim, slot0, 0.6)
end

function slot0._onRenameTalentTemplateReply(slot0)
	slot0:_initTemplateList()
end

function slot0._onUseTalentStyleReply(slot0)
	slot0._isCanPlaySwitch = true

	if slot0._cubeRoot[slot0._mainCubeId] then
		if slot0._cubeRoot[slot0._mainCubeId].root and slot0._cubeRoot[slot0._mainCubeId].item then
			slot0:_refreshAttrItem(slot0._mainCubeId)
		end
	end

	slot0:_setChessboardData()
	slot0:_chooseOtherStyleOrTemplate()

	slot0._canPlayCubeAnim = true

	slot0:_initTemplateList()
	slot0:_showMainCubeAttrTip()
	slot0:_playMainCubeSwitchAnim()
end

function slot0._showMainCubeAttrTip(slot0)
	if not slot0:_checkHasMainCubeInChess() then
		return
	end

	slot1 = {}
	slot6 = slot1

	slot0.hero_mo_data:getTalentStyleCubeAttr(slot0._mainCubeId, slot6, slot7, nil)

	slot2 = {}

	for slot6, slot7 in pairs(slot1) do
		table.insert(slot2, {
			key = slot6,
			value = slot7
		})
	end

	slot0:_showAttrTip(slot2)
end

function slot0._checkHasMainCubeInChess(slot0)
	for slot5, slot6 in pairs(slot0.hero_mo_data.talentCubeInfos.data_list) do
		if slot6.cubeId == slot0._mainCubeId then
			return true
		end
	end
end

function slot0._hideStyleUpdateAnim(slot0)
	gohelper.setActive(slot0._styleupdate, false)
end

function slot0._refreshStyleTag(slot0)
	slot2 = TalentStyleModel.instance:getTalentStyle(slot0._mainCubeId, slot0.hero_mo_data:getHeroUseCubeStyleId(slot0.hero_id))
	slot0._txtlabel.text, slot4 = slot2:getStyleTag()
	slot5, slot6 = slot2:getStyleTagIcon()

	UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._styleslot, slot6, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._styleicon, slot5, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(slot0._styleglow, slot5, true)
end

function slot0._showTemplateName(slot0)
	for slot4, slot5 in ipairs(slot0.hero_mo_data.talentTemplates) do
		if slot5.id == slot0.hero_mo_data.useTalentTemplateId then
			slot6 = luaLang("talent_charactertalentchess_template" .. CharacterEnum.TalentTxtByHeroType[slot0.hero_mo_data.config.heroType])
			slot7 = nil

			if not string.nilorempty(TalentStyleModel.instance:getTalentStyle(slot0._mainCubeId, slot5.style) and slot8._styleCo and slot8._styleCo.tagicon) then
				slot7 = string.format("<sprite=%s>", tonumber(slot9) - 1) .. (LangSettings.instance:isEn() and (string.nilorempty(slot5.name) and slot6 .. " " .. slot0._curSelectTemplateIndex or slot5.name) or string.nilorempty(slot5.name) and slot6 .. slot0._curSelectTemplateIndex or slot5.name)
			end

			slot0._txtgroupname.text = slot7
		end
	end
end

function slot0._onBtnChangeTemplateName(slot0)
	ViewMgr.instance:openView(ViewName.CharacterTalentModifyNameView, {
		slot0.hero_mo_data.heroId,
		slot0.hero_mo_data.talentTemplates[slot0._curSelectTemplateIndex].id
	})
end

function slot0.sortTemplate(slot0, slot1)
	return slot0.id < slot1.id
end

function slot0._onDropClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
end

function slot0._onStyleChangeClick(slot0)
	ViewMgr.instance:openView(ViewName.CharacterTalentChessFilterView, {
		heroId = slot0.hero_id
	})
end

function slot0._onMaxLevelClick(slot0)
	for slot4, slot5 in pairs(slot0.own_cube_list) do
		slot6 = slot5.id

		slot0:_refreshAttrItem(slot6, slot0._showMaxLVBtn and HeroConfig.instance:getTalentCubeMaxLevel(slot6))
	end

	slot0._showMaxLVBtn = not slot0._showMaxLVBtn

	slot0:_showMaxLvBtn()
	slot0._leftContentAnim:Play("chessview_content_open", 0, 0)
	slot0._leftContentAnim:Update(0)
end

function slot0._showMaxLvBtn(slot0)
	gohelper.setActive(slot0._gomaxselect, not slot0._showMaxLVBtn)
	gohelper.setActive(slot0._gomaxunselect, slot0._showMaxLVBtn)
end

function slot0._onCopyTalentData(slot0)
	for slot6, slot7 in ipairs(slot0.hero_mo_data.talentCubeInfos.data_list) do
		if slot6 ~= #slot1 then
			slot2 = "" .. table.concat({
				slot7.cubeId,
				slot7.direction,
				slot7.posX,
				slot7.posY
			}, ",") .. "#"
		end
	end

	ZProj.UGUIHelper.CopyText(slot2)
end

function slot0.onDestroyView(slot0)
	if slot0.parallel_sequence then
		slot0.parallel_sequence:destroy()
	end

	if slot0._update_attr_tips_ani then
		slot0._update_attr_tips_ani:destroy()
	end

	if slot0._put_ani_flow then
		slot0._put_ani_flow:unregisterDoneListener(slot0.onPutAniDone, slot0)
		slot0._put_ani_flow:destroy()
	end

	TaskDispatcher.cancelTask(slot0._playScrollTween, slot0)
	TaskDispatcher.cancelTask(slot0._hideStyleUpdateAnim, slot0)

	for slot6 = 0, slot0._goContent.transform.childCount - 1 do
		slot7 = slot1:GetChild(slot6):Find("item/slot").gameObject
		slot8 = SLFramework.UGUI.UIDragListener.Get(slot7)

		slot8:RemoveDragBeginListener()
		slot8:RemoveDragListener()
		slot8:RemoveDragEndListener()
		SLFramework.UGUI.UIClickListener.Get(slot7):RemoveClickDownListener()
	end

	if slot0.drag_container then
		slot0._dragContainerDragCom:RemoveDragBeginListener()
		slot0._dragContainerDragCom:RemoveDragListener()
		slot0._dragContainerDragCom:RemoveDragEndListener()
		SLFramework.UGUI.UIClickListener.Get(slot0.drag_container):RemoveClickListener()
	end

	if slot0.drag_image then
		for slot6, slot7 in ipairs(slot0.drag_image) do
			slot8 = SLFramework.UGUI.UIDragListener.Get(slot7)

			slot8:RemoveDragBeginListener()
			slot8:RemoveDragListener()
			slot8:RemoveDragEndListener()
			SLFramework.UGUI.UIClickListener.Get(slot7):RemoveClickListener()
		end
	end

	slot0:_releaseCellList()

	if slot0._dragEffectLoader then
		slot0._dragEffectLoader:dispose()

		slot0._dragEffectLoader = nil
	end
end

return slot0
