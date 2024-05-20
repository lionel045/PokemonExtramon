import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    @State private var isScaling = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 220, height: 40)
                .foregroundColor(.white)
                .cornerRadius(14)
                .scaleEffect(isScaling ? 1.40 : 1)
                .animation(.bouncy(duration: 0.2), value: isScaling)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading, 30)
                    .offset(x: isEditing ? -20 : 0)
                    .animation(Animation.linear(duration: 1), value: isEditing)
                
                TextField("Search", text: $text)
                    .frame(width: 190, height: 30)
                    .foregroundColor(.black)
                if isEditing || !text.isEmpty {
                    Button {
                        text = ""
                        isEditing.toggle()
                        isScaling.toggle()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(Color(.systemGray))
                    }
                }
            }
            .padding(10)
        }
        .onTapGesture {
            withAnimation {
                isEditing = true
                isScaling = true
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var searchText = ""

    static var previews: some View {
        SearchBar(text: $searchText)
    }
}

