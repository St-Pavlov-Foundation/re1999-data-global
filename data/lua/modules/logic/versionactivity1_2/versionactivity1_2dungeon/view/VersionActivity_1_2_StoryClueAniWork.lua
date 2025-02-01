module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_StoryClueAniWork", package.seeall)

slot0 = class("VersionActivity_1_2_StoryClueAniWork", BaseWork)

function slot0.ctor(slot0, slot1, slot2, slot3, slot4)
	slot0._signObjList = slot1
	slot0._viewClass = slot2
	slot0._index = slot3
	slot0._clueId = slot4

	slot0:_buildFlow()
end

function slot0._buildFlow(slot0)
	slot0._aniFlow = FlowSequence.New()
	slot1 = 100
	slot0._tweenValue = {}
	slot3 = slot0._viewClass._gomask.transform
	slot4 = gohelper.findChild(slot0._viewClass.viewGO, "root").transform
	uv0.lastNoteId = 0

	for slot8 = 1, #slot0._signObjList do
		for slot13, slot14 in ipairs(slot0._signObjList[slot8]) do
			slot15 = slot14.transform
			slot17 = recthelper.getWidth(slot15) / slot1

			recthelper.setWidth(slot15, 0)

			slot20 = slot15.parent.parent.gameObject.transform.name

			if uv0.lastNoteId == 0 then
				-- Nothing
			elseif uv0.lastNoteId ~= slot20 then
				slot0._aniFlow:addWork(WorkWaitSeconds.New(0.16))
				slot0._aniFlow:addWork(TweenWork.New({
					from = 1,
					type = "DOFadeCanvasGroup",
					to = 0,
					t = 0.3,
					go = slot2
				}))
			end

			if slot13 == 1 then
				slot22 = recthelper.rectToRelativeAnchorPos(gohelper.findChild(slot19.gameObject, "title/go_titleNormal").transform.position, slot0._viewClass.viewGO.transform)
				slot25 = FlowParallel.New()

				slot25:addWork(TweenWork.New({
					toz = 1,
					type = "DOScale",
					tox = 1.5,
					toy = 1.5,
					t = 0.3,
					tr = slot4
				}))
				slot25:addWork(TweenWork.New({
					type = "DOAnchorPos",
					t = 0.3,
					tr = slot4,
					tox = -slot22.x * 1.5 - 200,
					toy = -slot22.y * 1.5 + 80
				}))
				slot0._aniFlow:addWork(slot25)

				if uv0.lastNoteId ~= slot20 then
					slot0._aniFlow:addWork(FunctionWork.New(function ()
						recthelper.setWidth(uv0, 5200)
						recthelper.setHeight(uv0, 2500)
						gohelper.setActive(uv1, true)
					end))

					slot25 = FlowParallel.New()

					slot25:addWork(FunctionWork.New(function ()
						recthelper.setAnchorY(uv0, 0 - uv1 / 2)
					end))
					slot25:addWork(TweenWork.New({
						type = "DOSizeDelta",
						tox = 2600,
						t = 0.6,
						tr = slot3,
						toy = 1250 + (gohelper.findChildText(slot15.parent.gameObject, ""):GetPreferredValues().y - 112) * 1.5
					}))
					slot25:addWork(TweenWork.New({
						from = 0,
						type = "DOFadeCanvasGroup",
						to = 1,
						t = 0.6,
						go = slot2
					}))
					slot0._aniFlow:addWork(slot25)
				end
			end

			uv0.lastNoteId = slot20

			slot0._aniFlow:addWork(VersionActivity_1_2_StoryClueLineWork.New(slot15, slot16, slot17, slot0._clueId))

			if slot13 == #slot9 then
				slot0._aniFlow:addWork(WorkWaitSeconds.New(0.6))
			end

			table.insert(slot0._tweenValue, {
				tr = slot15,
				to = slot16
			})
		end
	end

	uv0.lastNoteId = 0

	slot0._aniFlow:addWork(TweenWork.New({
		from = 1,
		type = "DOFadeCanvasGroup",
		to = 0,
		t = 0.3,
		go = slot2
	}))
	slot0._aniFlow:addWork(TweenWork.New({
		type = "DOAnchorPos",
		tox = -556,
		toy = 466,
		t = 0.3,
		tr = slot4
	}))

	slot6 = slot0._viewClass._gocollectNote.transform:GetChild(slot0._index - 1).gameObject

	slot0._aniFlow:addWork(FunctionWork.New(function ()
		gohelper.setActive(uv0, true)
	end))

	slot7 = gohelper.findChild(slot6, VersionActivity_1_2_StoryCollectView._signTypeName[slot0._clueId]).transform
	slot8 = recthelper.getWidth(slot7)

	recthelper.setWidth(slot7, 0)
	slot0._aniFlow:addWork(VersionActivity_1_2_StoryClueLineWork.New(slot7, slot8, slot8 / slot1, slot0._clueId))
	slot0._aniFlow:addWork(WorkWaitSeconds.New(1))
	table.insert(slot0._tweenValue, {
		tr = slot7,
		to = slot8,
		collectNoteItem = slot6
	})
end

function slot0.onStart(slot0)
	slot0._aniFlow:registerDoneListener(slot0._onAniFlowDone, slot0)
	slot0._aniFlow:start()
end

function slot0._onAniFlowDone(slot0)
	if slot0._aniFlow then
		slot0._aniFlow:unregisterDoneListener(slot0._onAniFlowDone, slot0)
		slot0._aniFlow:destroy()

		slot0._aniFlow = nil
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._aniFlow then
		slot0._aniFlow:unregisterDoneListener(slot0._onAniFlowDone, slot0)
		slot0._aniFlow:destroy()

		slot0._aniFlow = nil
	end
end

return slot0
