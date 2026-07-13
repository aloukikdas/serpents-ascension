# Game Architecture

## Scene Tree
```text
Main (Node2D)
├── Background
├── Camera2D
├── Board (Node2D)
│   ├── Tiles (Node2D)
│   │   └── Tile (Node2D)
│   │       ├── Visual (Node2D)
│   │       │   ├── Sprite2D
│   │       │   └── Label
│   │       ├── Area2D
│   │       │   └── CollisionShape2D
│   │       ├── AnimationPlayer
│   │       └── PieceAnchor (Marker2D)
│   ├── Decorations (Node2D)
│   └── Effects (Node2D)
└── CanvasLayer (UI)
```

## Managers (AutoLoads)
* **GameManager:** Global game state.
* **TurnManager:** Player turn sequence.
* **DiceManager:** Roll logic.
* **PlayerManager:** Player data.
* **BoardManager:** Grid math and tile logic.
* **SnakeManager / LadderManager:** Traversal logic.
* **AudioManager:** SFX / Music.
* **SaveManager:** Disk I/O.
* **DialogueManager:** Narrative.
* **UIManager:** Overlays.

## Core Responsibilities
* **Board:** Manages grid generation, visual hierarchy, and tile retrieval.
* **Tile:** A data container object holding its ID, grid position, and exact spatial anchor (`PieceAnchor`) for player alignment. Handles its own visual state (glow, highlight) but contains no game logic.
