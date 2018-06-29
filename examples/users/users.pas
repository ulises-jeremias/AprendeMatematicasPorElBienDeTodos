PROGRAM linkedlists;
USES Crt;

TYPE
	TStudRec = RECORD
		Name, Surname: String;
		Id, Age: Integer;
		Gender: Char;
	END;

	TNodePtr = ^TNode;

	TNode = RECORD
		StudRec: TStudRec;
		NodePtr: TNodePtr;
	END;

VAR
	Head, Tail: TNodePtr;
	SampleRecord: TStudRec;

procedure InitLL;
	begin
		Head := nil;
		Tail := Head;
	end;

procedure AddRecord(StudRec: TStudRec);
	var
	Node: TNode;

	begin
		Node.StudRec := StudRec;
		New(Node.NodePtr);

		if Head = nil then
		begin
			New(Head);
			New(Tail);
			Head^ := Node;
		End Else
		begin
			Tail^.NodePtr^ := Node;
		end;

		Tail^ := Node;
	end;

procedure InsertRecordByIndex(Index: Integer; StudRec: TStudRec);
	var
		i: Integer;
		TempPtr: TNodePtr;
		Node, TempNode: TNode;
		Done: Boolean;

	begin
		Done := False;

		if Head = nil then
			Exit;

		i := 0;
		TempPtr := Head;
		Node.StudRec := StudRec;
		New(Node.NodePtr);

		if (Index = 0) then
		begin
			TempNode := Head^;
			Head^ := Node;
			Node.NodePtr^ := TempNode;
			Done := True;
		end;

		if not Done then
			while (i < Index-1) do
			begin
				if (TempPtr^.NodePtr^.NodePtr = nil) then
				begin
					Done := True;
					Break;
				end;

				i := i + 1;
				TempPtr := TempPtr^.NodePtr;
			end;

		if not Done then
		begin
			TempNode := TempPtr^.NodePtr^;
			TempPtr^.NodePtr^ := Node;
			Node.NodePtr^ := TempNode;
		end;
	end;

procedure InsertRecordByID(ID: Integer; StudRec: TStudRec);
	var
		TempPtr: TNodePtr;
		Node, TempNode: TNode;
		Done: Boolean;

	begin
		Done := False;

		if Head = nil then
			Exit;

		TempPtr := Head;
		Node.StudRec := StudRec;
		New(Node.NodePtr);

		if (TempPtr^.StudRec.ID = ID) then
		begin
			TempNode := Head^;
			Head^ := Node;
			Node.NodePtr^ := TempNode;
			Done := True;
		end;

		while not Done do
		begin
			if (TempPtr^.StudRec.ID = ID) then
				Break;

			if (TempPtr^.NodePtr^.NodePtr = nil) then
			begin
				Done := True;
				Break;
			end;

			TempPtr := TempPtr^.NodePtr;
		end;

		if not Done then
		begin
			TempNode := TempPtr^.NodePtr^;
			Node.NodePtr^ := TempNode;
			TempPtr^.NodePtr^ := Node;
		end;
	end;

procedure DeleteNodeWithID(ID: Integer);
	var
		TempPtr, PrevPtr: TNodePtr;
		Done: Boolean;

	begin
		Done := False;

		if Head = nil then
			Exit;

		PrevPtr := Head;
		TempPtr := Head;

		while True do
		begin
			if (TempPtr^.StudRec.ID = ID) then
				Break;

			if (TempPtr^.NodePtr^.NodePtr = nil) then
			begin
			Done := True;
			Break;
			end;

			PrevPtr := TempPtr;
			TempPtr := TempPtr^.NodePtr;
		end;
		if not Done then
		begin
			if TempPtr = Head then
				Head := Head^.NodePtr
			Else
			begin
				PrevPtr^.NodePtr := TempPtr^.NodePtr;
			end;
		end;
	end;

procedure PrintAll(Head: TNodePtr);
	var
		Node: TNodePtr;

	begin
		New(Node);
		Node := Head;
		while Node^.NodePtr <> nil do
		begin
			Writeln('=================');
			Writeln(Node^.StudRec.Name);
			Writeln(Node^.StudRec.Surname);
			Writeln(Node^.StudRec.Id);
			Writeln(Node^.StudRec.Age);
			Writeln(Node^.StudRec.Gender);
			Writeln('=================');

			Node := Node^.NodePtr;
		end;
		Writeln('Done Printing.');
	end;

procedure AssignRecord(StudRec: TStudRec; Name, Surname: String; ID, Age: Integer; Gender: Char);
	begin
		SampleRecord.Name := Name;
		SampleRecord.Surname := Surname;
		SampleRecord.Age := Age;
		SampleRecord.Id  := Id;
		SampleRecord.Gender := Gender;
	end;

BEGIN
	ClrScr;
	InitLL;

	AssignRecord(SampleRecord, 'Victor', 'Saliba', 19, 12345, 'M');
	AddRecord(SampleRecord);
	AssignRecord(SampleRecord, 'Mario', 'Petrack', 42, 00011, 'M');
	AddRecord(SampleRecord);
	AssignRecord(SampleRecord, 'Mary', 'Kels', 22, 20211, 'F');
	AddRecord(SampleRecord);
	AssignRecord(SampleRecord, 'Ken', 'Bolimpart', 19, 04148, 'M');
	AddRecord(SampleRecord);
	AssignRecord(SampleRecord, 'Kelly', 'Becks', 16, 04148, 'F');

	InsertRecordByID(00011, SampleRecord);
	DeleteNodeWithID(20211);

	Writeln('Done...');
	PrintAll(Head);
	Readln;
END.
