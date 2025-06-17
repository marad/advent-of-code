package lib

type XY struct{ X, Y int }

type IntPoint2D struct{ XY }

type Dir int

const (
	Up Dir = iota
	Right
	Down
	Left
	UpRight
	UpLeft
	DownRight
	DownLeft
)

var Dirs = []Dir{
	UpLeft, Up, UpRight,
	Left, Right,
	DownLeft, Down, DownRight,
}

func RotateRight90(dir Dir) Dir {
	switch dir {
	case Up:
		return Right
	case Right:
		return Down
	case Down:
		return Left
	case Left:
		return Up
	case UpRight:
		return DownRight
	case DownRight:
		return DownLeft
	case DownLeft:
		return UpLeft
	case UpLeft:
		return UpRight
	}
	return dir
}

// Creates new XY moved up by one
func (self XY) Up() XY { return XY{self.X, self.Y - 1} }

// Creates new XY moved down by one
func (self XY) Down() XY { return XY{self.X, self.Y + 1} }

// Creates new XY moved left by one
func (self XY) Left() XY { return XY{self.X - 1, self.Y} }

// Creates new XY moved right by one
func (self XY) Right() XY { return XY{self.X + 1, self.Y} }

// Moves curent XY up by one
func (self *XY) MoveUp() { self.Y -= 1 }

// Moves curent XY down by one
func (self *XY) MoveDown() { self.Y += 1 }

// Moves curent XY left by one
func (self *XY) MoveLeft() { self.X -= 1 }

// Moves curent XY right by one
func (self *XY) MoveRight() { self.X += 1 }

// Creates new XY moved by one in given direction
func (self XY) ApplyDir(dir Dir) XY {
	switch dir {
	case Up:
		return self.Up()
	case Down:
		return self.Down()
	case Left:
		return self.Left()
	case Right:
		return self.Right()
	case UpRight:
		return self.Up().Right()
	case UpLeft:
		return self.Up().Left()
	case DownRight:
		return self.Down().Right()
	case DownLeft:
		return self.Down().Left()
	}
	return self
}

// Modifies the XY moving it by one in given direction
func (self *XY) Move(dir Dir) {
	switch dir {
	case Up:
		self.MoveUp()
	case Down:
		self.MoveDown()
	case Left:
		self.MoveLeft()
	case Right:
		self.MoveRight()
	case UpRight:
		self.MoveUp()
		self.MoveRight()
	case UpLeft:
		self.MoveUp()
		self.MoveLeft()
	case DownRight:
		self.MoveDown()
		self.MoveRight()
	case DownLeft:
		self.MoveDown()
		self.MoveLeft()
	}
}
