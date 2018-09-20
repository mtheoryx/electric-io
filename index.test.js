let req = {
  body: {}
}

let res = {
  sendCalledWith: '',
  send: function(arg) {
    this.sendCalledWith = arg;
  }
};

describe('It does hello!', () =>{
  it('Should be alive!', () => {
    
  });
});